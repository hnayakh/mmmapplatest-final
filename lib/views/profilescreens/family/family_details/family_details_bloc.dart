import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profilescreens/family/family_details/family_details_events.dart';
import 'package:makemymarry/views/profilescreens/family/family_details/family_details_state.dart';
import 'package:makemymarry/views/profilescreens/family/globals.dart'
    as globals;

class FamilyDetailsBloc extends Bloc<FamilyDetailsEvent, FamilyDetailState> {
  final UserRepository userRepository;
  //late final String familyBackgroundSaved;
  FamilyDetailsBloc(
    this.userRepository,
  ) : super(FamilyDetailInitialState());
  FatherOccupation? fatherOccupation;
  MotherOccupation? motherOccupation;
  //String? familyBackgroundSaved;
  ProfileDetails? profileDetails;
  int noOfBrothers = 0, noOfSister = 0, brotherMarried = 0, sistersMarried = 0;

  @override
  Stream<FamilyDetailState> mapEventToState(FamilyDetailsEvent event) async* {
    yield OnLoading();
    if (event is onFamilyDetailDataLoad) {
      var result = await this.userRepository.getOtheruserDetails(
          event.basicUserId, ProfileActivationStatus.Verified);

      if (result.status == AppConstants.SUCCESS) {
        this.profileDetails = result.profileDetails;
        yield familyDetailsDataState(result.profileDetails);
      } else {
        yield OnError(result.message);
      }
    }
    print('infamildetailsbloc');
    //print(familyBackgroundSaved);
    if (event is OnFathersOccupationSelected) {
      this.fatherOccupation = event.occupation;
      yield FamilyDetailInitialState();
    }
    if (event is OnMothersOccupationSelected) {
      this.motherOccupation = event.occupation;
      yield FamilyDetailInitialState();
    }
    if (event is ChangeNoOfBrothers) {
      this.noOfBrothers += event.change;
      if (noOfBrothers < 0) {
        this.noOfBrothers = 0;
      }
      if (noOfBrothers > 10) {
        this.noOfBrothers = 10;
      }
      if (noOfBrothers < brotherMarried) {
        yield OnError('Please check number of married brothers');
      }
      yield FamilyDetailInitialState();
    }
    if (event is ChangeNoOfSisters) {
      this.noOfSister += event.change;
      if (noOfSister < 0) {
        this.noOfSister = 0;
      }
      if (noOfSister > 10) {
        this.noOfSister = 10;
      }
      if (noOfSister < sistersMarried) {
        yield OnError('Please check number of married sisters');
      }
      yield FamilyDetailInitialState();
    }
    if (event is ChangeNoOfSistersMarried) {
      this.sistersMarried += event.change;
      if (sistersMarried > noOfSister) {
        this.sistersMarried = noOfSister;
      }
      if (sistersMarried < 0) {
        this.sistersMarried = 0;
      }

      yield FamilyDetailInitialState();
    }
    if (event is ChangeNoOfBrothersMarried) {
      this.brotherMarried += event.change;
      if (brotherMarried > noOfBrothers) {
        this.brotherMarried = noOfBrothers;
      }
      if (brotherMarried < 0) {
        this.brotherMarried = 0;
      }

      yield FamilyDetailInitialState();
    }
    if (event is UpdateFamilyDetails) {
      this.fatherOccupation = event.fatherOccupation;
      this.motherOccupation = event.motherOccupation;
      this.noOfBrothers = event.noOfBrothers;
      this.noOfSister = event.noOfSister;
      this.brotherMarried = event.brotherMarried;
      this.sistersMarried = event.sistersMarried;
      // print('inoncomplete3');
      // // print(familyBackgroundSaved);
      // if (globals.familyBackgroundComplete == false) {

      //yield OnError("Please submit Family Background first");
      //  }
      // else
      if (this.fatherOccupation == null &&
          this.motherOccupation == null &&
          this.noOfBrothers == 0 &&
          this.noOfSister == 0 &&
          this.brotherMarried == 0 &&
          this.sistersMarried == 0) {
        await this
            .userRepository
            .storageService
            .saveUserDetails(this.userRepository.useDetails!);
        this.userRepository.updateRegistrationStep(6);
        globals.familyBackgroundComplete = false;
        yield OnFamilyDetailsUpdated();
      } else if (this.fatherOccupation == null) {
        yield OnError("Select Father's Occupation");
      } else if (this.motherOccupation == null) {
        yield OnError("Select Mother's Occupation");
      } else {
        var result = await this.userRepository.updateFamilyDetails(
            fatherOccupation!,
            motherOccupation!,
            noOfBrothers,
            noOfSister,
            brotherMarried,
            sistersMarried);
        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails!.registrationStep =
              result.userDetails!.registrationStep;
          //await this.userRepository.saveUserDetails();
          await this
              .userRepository
              .storageService
              .saveUserDetails(this.userRepository.useDetails!);
          this.userRepository.updateRegistrationStep(6);
          globals.familyBackgroundComplete = false;
          print('in familydetails');
          print(
              'dobinfamDetailsbloc=${this.userRepository.useDetails!.dateOfBirth}');
          print(this.userRepository.useDetails!.registrationStep);
          if (!event.isAnUpdate) {
            this.userRepository.updateRegistrationStep(6);
          }
          yield event.isAnUpdate
              ? OnNavigationToMyProfiles()
              : OnFamilyDetailsUpdated();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
