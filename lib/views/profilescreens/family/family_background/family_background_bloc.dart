import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/family_background_event.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/family_background_state.dart';

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
  final CountryModel? selectedCountry;
  final StateModel? selectedState;
  final StateModel? selectedCity;

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
      this.countryModel = event.countryModel;
      yield FamilyBackgroundState();
    }
    if (event is OnStateSelected) {
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
      var result = await this.userRepository.getStates(this.countryModel!.id);
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotStates(result.list);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is GetAllCities) {
      var result = await this.userRepository.getCities(this.myState!.id);
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotCities(result.list);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is UpdateFamilyBackground) {
      if (this.level == null &&
          this.values == null &&
          !this.isStayingWithParents &&
          myState == null &&
          city == null) {
        await this
            .userRepository
            .storageService
            .saveUserDetails(this.userRepository.useDetails!);
        this.userRepository.updateRegistrationStep(8);
        yield OnUpdate();
        //yield OnError('Enter your family background');
      }
      // if (this.level == null) {
      //   yield OnError("Select Family Status");
      // } else if (this.values == null) {
      //   yield OnError("Select Family Values");
      // } else if (!this.isStayingWithParents && this.countryModel == null) {
      //   yield OnError("Select Country");
      // } else if (!this.isStayingWithParents && myState == null) {
      //   yield OnError("Select State");
      // } else if (!this.isStayingWithParents && city == null) {
      //   yield OnError("Select City");
      // } else {
      var result = await this.userRepository.updateFamilyBackground(
          this.level!,
          this.values!,
          this.type,
          this.isStayingWithParents
              ? this.selectedCountry!
              : this.countryModel!,
          this.isStayingWithParents ? this.selectedState! : this.myState!,
          this.isStayingWithParents ? this.selectedCity! : this.city!);
      if (result.status == AppConstants.SUCCESS) {
        this.userRepository.useDetails!.registrationStep =
            result.userDetails!.registrationStep;
        //await this.userRepository.saveUserDetails();
        await this
            .userRepository
            .storageService
            .saveUserDetails(this.userRepository.useDetails!);
        this.userRepository.updateRegistrationStep(8);
        print('in familybackground');
        print(
            'dobinfambackbloc=${this.userRepository.useDetails!.dateOfBirth}');
        print(this.userRepository.useDetails!.registrationStep);
        yield OnUpdate();
      } else {
        yield OnError(result.message);
      }
      //  }
    }
  }
}
