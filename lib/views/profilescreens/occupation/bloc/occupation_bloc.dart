import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

import 'occupation_event.dart';
import 'occupation_state.dart';

class OccupationBloc extends Bloc<OccupationEvent, OccupationState> {
  final UserRepository userRepository;

  String? occupation;
  String? education;
  late String income;
  CountryModel? countryModel;
  CountryModel? prevCountryModel;
  StateModel? myState, city, prevState;

  AnnualIncome? annualIncome;
  ProfileDetails? profileDetails;

  OccupationBloc(this.userRepository) : super(OccupationInitialState()) {
    this.countryModel = userRepository.useDetails!.countryModel;
  }

  @override
  Stream<OccupationState> mapEventToState(OccupationEvent event) async* {
    yield OnLoading();
    if (event is onOccupationDataLoad) {
      var result = await this.userRepository.getOtheruserDetails(
          event.basicUserId, ProfileActivationStatus.Verified);

      if (result.status == AppConstants.SUCCESS ) {
        this.profileDetails = result.profileDetails;
        if (this.education == null )
          this.education = this.profileDetails!.highiestEducation;
        if (this.occupation == null)
          this.occupation = this.profileDetails!.occupation;
        if (this.annualIncome == null)
          this.annualIncome = this.profileDetails!.annualIncome;
        // if(this.countryModel == null){
          var countryName = this.profileDetails!.country;
          var countryId = this.profileDetails!.countryId;
          var countryCode = this.profileDetails!.countryCode;
          this.countryModel = CountryModel.fromJson({'name': countryName, 'id': countryId,'phoneCode': int.parse(countryCode),"shortName":countryName  });
        // }
        if (this.city == null) {
          var cityName = this.profileDetails!.city;
          var cityId = this.profileDetails!.cityId;
          this.city = StateModel(cityName, cityId);
        }
        if (this.myState == null) {
          var stateName = this.profileDetails!.state;
          var stateId = this.profileDetails!.stateId;
          this.myState = StateModel(stateName, stateId);
        }
        yield OccupationDetailsState(result.profileDetails);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is OnAnnualIncomeSelected) {
      this.annualIncome = event.income;
      yield OccupationInitialState();
    }
    if (event is OnOccupationSelected) {
      this.occupation = event.occupation;
      yield OccupationInitialState();
    }
    if (event is OnEducationSelected) {
      this.education = event.education;
      yield OccupationInitialState();
    }
    if (event is OnCountrySelected) {
      if (this.countryModel == null) {
        this.countryModel = event.countryModel;
      } else {
        this.prevCountryModel = this.countryModel;
        this.countryModel = event.countryModel;
        if (this.prevCountryModel!.name != this.countryModel!.name) {
          this.myState = null;
          this.city = null;
        }
      }
      yield OccupationInitialState();
    }
    if (event is OnStateSelected) {
      if (this.myState == null) {
        this.myState = event.stateModel;
      } else {
        this.prevState = this.myState;
        this.myState = event.stateModel;
        if (this.myState!.name != this.prevState!.name) {
          this.city = null;
        }
      }
      yield OccupationInitialState();
    }
    if (event is OnCitySelected) {
      this.city = event.stateModel;
      yield OccupationInitialState();
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
      if (this.myState == null) {
        yield OnError('Enter name of state belonging to.');
      }
      var result = await this.userRepository.getCities(this.myState!.id);
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotCities(result.list);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is UpdateCareer) {
      // this.nameOfOrg = event.name;
      this.occupation = event.occupation;
      this.annualIncome = event.anualIncome;
      this.education = event.education;
      this.myState = event.myState;
      this.city = event.city;

      if ((this.annualIncome == null || this.annualIncome == AnnualIncome.NotMentioned) &&
         (this.myState == null || this.myState?.id == -1) &&
           (this.countryModel?.id == -1 || this.countryModel == null || (this.countryModel?.id == 101 && (this.city == null || this.city?.id == -1)))&&
          !this.occupation.isNotNullEmpty &&
          !this.education.isNotNullEmpty) {
        yield OnError('Please enter all mandatory career details');
      }
      else if ( !this.occupation.isNotNullEmpty) {
        yield OnError('Please select your occupation.');
      }
      if (this.annualIncome == null || this.annualIncome == AnnualIncome.NotMentioned) {
        yield OnError('Enter annual income.');
      }  else if ( !this.education.isNotNullEmpty) {
        yield OnError('select your educational qualifications.');
      }else if (this.countryModel == null || this.countryModel?.id == -1) {
        yield OnError('Enter name of country belonging to.');
      } else if (this.myState == null || this.myState?.id == -1) {
        yield OnError('Enter name of state belonging to.');
      } else if (this.countryModel?.id == 101 && (this.city == null || this.city?.id == -1)) {
        yield OnError('Enter name of city belonging to.');
      } else {
        var result = await this.userRepository.career(
              this.occupation!,
              this.annualIncome!,
              this.education!,
              this.countryModel!,
              this.myState!,
              this.city ?? StateModel("", 0),
            );

        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails!.registrationStep =
              result.userDetails!.registrationStep;
          this.userRepository.useDetails!.countryModel = this.countryModel!;
          await this
              .userRepository
              .storageService
              .saveUserDetails(this.userRepository.useDetails!);
          if (!event.isAnUpdate) {
            await this
                .userRepository
                .updateRegistartionStep(this.userRepository.useDetails!.id, 5);
            this.userRepository.updateRegistrationStep(5);
          }
          yield event.isAnUpdate ? OnNavigationToMyProfiles() : MoveToFamily();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
