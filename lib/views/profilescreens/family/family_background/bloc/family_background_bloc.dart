import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/bloc/family_background_event.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/bloc/family_background_state.dart';

class FamilyBackgroundBloc
    extends Bloc<FamilyBackgroundEvent, FamilyBackgroundState> {
  final UserRepository userRepository;

  FamilyAfluenceLevel? level;
  FamilyValues? values;
  FamilyType type = FamilyType.Nuclear;
  CountryModel? countryModel;
  StateModel? myState, city;
  late bool canSelectStayingWithParent;
  bool isStayingWithParents = false;
  CountryModel? selectedCountry;
  StateModel? selectedState;
  StateModel? selectedCity;
  ProfileDetails? profileDetails;

  FamilyBackgroundBloc(this.userRepository, this.selectedCountry,
      this.selectedState, this.selectedCity)
      : super(FamilyBackgroundInitialState()) {
    this.countryModel = userRepository.useDetails!.countryModel;
    if (countryModel != null && myState != null && city != null) {
      canSelectStayingWithParent = false;
    } else {
      canSelectStayingWithParent = true;
    }
  }

  @override
  Stream<FamilyBackgroundState> mapEventToState(
      FamilyBackgroundEvent event) async* {
    yield OnLoading();
    if (event is onFamilyBackgroundDataLoad) {
      var result = await this.userRepository.getOtheruserDetails(
          event.basicUserId, ProfileActivationStatus.Verified);

      if (result.status == AppConstants.SUCCESS) {
        this.profileDetails = result.profileDetails;
        if (this.level == null)
          this.level = this.profileDetails!.familyAfluenceLevel;

        if (this.values == null)
          this.values = this.profileDetails!.familyValues;

        this.isStayingWithParents =  this.profileDetails!.isResidingWithFamily;
        this.type = this.profileDetails!.familyType;

        var countryName = this.profileDetails!.familyCountry;
        var countryId = this.profileDetails!.familyCountryId;
        // if(profileDetails)
        if (countryId >= 0) {
          this.countryModel = CountryModel.fromJson({
            "name": countryName,
            "shortName": countryName,
            "id": countryId,
            "phoneCode": 0,
          });
        } else {
          this.countryModel = null;
        }
        var stateName = this.profileDetails!.familyState;
        var stateId = this.profileDetails!.familyStateId;
        if (stateId >= 0) {
          this.myState = StateModel(stateName, stateId);
        } else {
          this.myState = null;
        }

        var cityName = this.profileDetails!.familyCity;
        var cityId = this.profileDetails!.familyCityId;
        if (cityId >= 0) {
          this.city = StateModel(cityName, cityId);
        } else {
          this.city = null;
        }
        var selectedCountryName = this.profileDetails!.country;
        var selectedCountryId = this.profileDetails!.countryId;

        if (selectedCountryId >= 0) {
          this.selectedCountry = CountryModel.fromJson({
            "name": selectedCountryName,
            "shortName": selectedCountryName,
            "id": selectedCountryId,
            "phoneCode": 0,
          });
        } else {
          this.selectedCountry = null;
        }
        var selectedStateName = this.profileDetails!.state;
        var selectedStateId = this.profileDetails!.stateId;
        if (selectedStateId >= 0) {
          this.selectedState = StateModel(selectedStateName, selectedStateId);
        } else {
          this.selectedState = null;
        }

        var selectedCityName = this.profileDetails!.city;
        var selectedCityId = this.profileDetails!.cityId;
        if (selectedCityId >= 0) {
          this.selectedCity = StateModel(selectedCityName, selectedCityId);
        } else {
          this.selectedCity = null;
        }
        yield familyBackgroundDataState(result.profileDetails);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is OnStayingWithParentsChanged) {
      this.isStayingWithParents = event.isStayingWithParents;
      yield FamilyBackgroundState();
    }
    if (event is OnFamilyStatusSelected) {
      this.level = event.level;
      yield FamilyBackgroundState();
    }
    if (event is OnFamilyValueSelected) {
      this.values = event.value;
      yield FamilyBackgroundState();
    }
    if (event is OnFamilyTypeChanges) {
      this.type = event.familyType;
      yield FamilyBackgroundState();
    }
    if (event is OnCountrySelected) {
      if (this.countryModel?.id != event.countryModel.id) {
        this.myState = null;
        this.city = null;
      }
      this.countryModel = event.countryModel;
      yield FamilyBackgroundState();
    }
    if (event is OnStateSelected) {
      if (this.myState?.id != event.stateModel.id) {
        this.city = null;
      }
      this.myState = event.stateModel;
      yield FamilyBackgroundState();
    }
    if (event is OnCitySelected) {
      this.city = event.stateModel;
      yield FamilyBackgroundState();
    }
    if (event is GetAllCountries) {
      var result = await this.userRepository.getCountries();
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotCounties(result.list);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is GetAllStates) {
      if (this.countryModel == null) {
        yield OnError("Select Country");
        return;
      }
      var result = await this.userRepository.getStates(this.countryModel!.id);
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotStates(result.list);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is GetAllCities) {
      if (this.myState == null) {
        yield OnError("Select State");
        return;
      }
      var result = await this.userRepository.getCities(this.myState!.id);
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotCities(result.list);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is UpdateFamilyBackground) {
      this.level = event.level;
      this.values = event.values;
      this.isStayingWithParents = event.isStayingWithParents;
      this.city = event.city;
      this.myState = event.myState;
      this.type = event.type ?? FamilyType.Notmentioned;

      if ((this.level == null ||
              this.level != FamilyAfluenceLevel.NotMentioned) &&
          (this.values == null || this.values == FamilyValues.NotMentioned) &&
          (this.type == FamilyType.Notmentioned) &&
          (this.isStayingWithParents && myState == null)) {
        yield OnError('Enter your family background');
      }
      if (this.level == null ||
          this.level == FamilyAfluenceLevel.NotMentioned) {
        yield OnError("Select Family Status");
      } else if (this.values == null ||
          this.values == FamilyValues.NotMentioned) {
        yield OnError("Select Family Values");
      } else if (this.type == FamilyType.Notmentioned) {
        yield OnError("Select Family Type");
      } else if (!this.isStayingWithParents && this.countryModel == null) {
        yield OnError("Select Country");
      } else if (!this.isStayingWithParents && myState == null) {
        yield OnError("Select State");
      } else if (!this.isStayingWithParents &&
          city == null &&
          this.countryModel?.id == 101) {
        yield OnError("Select City");
      } else {
        var result = await this.userRepository.updateFamilyBackground(
              this.level!,
              this.values!,
              this.type,
              this.isStayingWithParents
                  ? this.selectedCountry!
                  : this.countryModel!,
              this.isStayingWithParents ? this.selectedState! : this.myState!,
              this.isStayingWithParents
                  ? this.selectedCity!
                  : (this.city ?? StateModel("", -1)),
              this.isStayingWithParents,
            );
        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails!.registrationStep =
              result.userDetails!.registrationStep;
          await this
              .userRepository
              .storageService
              .saveUserDetails(this.userRepository.useDetails!);

          if (!event.isAnUpdate) {
            await this
                .userRepository
                .updateRegistartionStep(this.userRepository.useDetails!.id, 6);
            this.userRepository.updateRegistrationStep(6);
          }
          yield OnUpdate();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
