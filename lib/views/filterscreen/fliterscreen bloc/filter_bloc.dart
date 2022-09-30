import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';

import 'package:makemymarry/utils/mmm_enums.dart';

import 'filter_event.dart';
import 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  late final UserRepository userRepository;

  FilterBloc(this.userRepository) : super(FilterInitialState());

  MaritalStatusFilter? maritalStatus;
  EatingHabitFilter? foodStatus;
  DrinkingHabitFilter? drinkingStatus;
  SmokingHabit? smokeStatus;
  InterestFilter? interestStatus;
  ManglikFilter? isManglik;
  EmployeedInFilter? employeedIn;
  AbilityStatus? abilityStatus;
  ChildrenStatus? childrenStatus;
  NoOfChildren? noOfChildren;
  dynamic heightStatus;
  int? profileby;
  int? disabilityType;
  SimpleMasterData? religion;
  String? motherTongue;
  String? education;
  dynamic gothra;
  //CastSubCast? cast;
  String? caste;
  String? occupation;

  @override
  Stream<FilterState> mapEventToState(FilterEvent event) async* {
    yield OnLoading();
    if (event is OnMaritalFilterSelected) {
      this.maritalStatus = event.ms;
      yield FilterInitialState();
    }
    if (event is OnFoodFilterSelected) {
      this.foodStatus = event.foodStatus;
      yield FilterInitialState();
    }
    if (event is OnDrinkFilterSelected) {
      this.drinkingStatus = event.drinkStatus;
      yield FilterInitialState();
    }
    if (event is OnSmokeFilterSelected) {
      this.smokeStatus = event.smokeStatus;
      yield FilterInitialState();
    }
    if (event is OnInterestFilterSelected) {
      this.interestStatus = event.interestStatus;
      yield FilterInitialState();
    }
    if (event is OnEmployeedInFilterSelected) {
      this.employeedIn = event.employeedIn;
      yield FilterInitialState();
    }
    if (event is OnManglikFilterSelected) {
      this.isManglik = event.isManglik;
      yield FilterInitialState();
    }
    if (event is OnHeightFilterSelected) {
      this.heightStatus = event.height;
      yield FilterInitialState();
    }
    if (event is OnProfileFilterSelected) {
      this.profileby = event.profileby;
      yield FilterInitialState();
    }
    if (event is OnDisabilityFilterSelected) {
      this.disabilityType = event.disabilityType;
      yield FilterInitialState();
    }
    if (event is OnReligionFilterSelected) {
      this.religion = event.religion;
      yield FilterInitialState();
    }
    if (event is OnCastFilterSelected) {
      this.caste = event.caste;
      yield FilterInitialState();
    }
    if (event is OnMotherTongueFilterSelected) {
      this.motherTongue = event.motherTongue;
      yield FilterInitialState();
    }
    if (event is OnGothraFilterSelected) {
      this.gothra = event.gothra;
      yield FilterInitialState();
    }
    if (event is OnOccupationFilterSelected) {
      this.occupation = event.occupation;
      yield FilterInitialState();
    }
    if (event is OnEducationFilterSelected) {
      this.education = event.education;
      yield FilterInitialState();
    }
    //  if (event is OnFilterDone) {
    //
    //     if (this.maritalStatus == null) {
    //      yield OnError('Select marital status.');
    //    } else if (this.heightStatus == null) {
    //      yield OnError('Select your height.');
    //    } else {
    //       var result = await this.userRepository.Filter(
    //          this.noOfChildren,
    // //         this.maritalStatus,
    //         this.abilityStatus,
    //         this.childrenStatus,
    //        this.heightStatus,
    //        );
    //
    //     if (result.status == AppConstants.SUCCESS) {
    //      this.userRepository.useDetails = result.userDetails;
    // await this.userRepository.saveUserDetails();
    //       yield OnNavigationTo();
    //     } else {
    //      yield OnError(result.message);
    //    }
    //    }
    //   }
  }

  bool checkCaste() {
    if (this.religion != null) {
      if (casteNotAvailable()) {
        return false;
      } else {
        return true;
      }
    }
    return true;
  }

  bool casteNotAvailable() {
    return this.religion!.title.toLowerCase().contains("budhhist") ||
        this.religion!.title.toLowerCase().contains("parsi") ||
        this.religion!.title.toLowerCase().contains("jewish") ||
        this.religion!.title.toLowerCase().contains("other") ||
        this.religion!.title.toLowerCase().contains("no religion") ||
        this.religion!.title.toLowerCase().contains("spiritual");
  }
}
