import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

import 'religion_event.dart';
import 'religion_state.dart';

class ReligionBloc extends Bloc<ReligionEvent, ReligionState> {
  final UserRepository userRepository;

  SimpleMasterData? religion;
  dynamic subCaste;
  CastSubCast cast = CastSubCast("", []);
  SimpleMasterData? motherTongue;
  dynamic gothra;
  Manglik isManglik = Manglik.NotApplicable;
  ProfileDetails? profileDetails;

  SimpleMasterData? prevReligion;

  ReligionBloc(this.userRepository) : super(ReligionInitialState());

  @override
  Stream<ReligionState> mapEventToState(ReligionEvent event) async* {
    yield OnReligionLoading();
    if (event is onReligionDataLoad) {
      var result = await this.userRepository.getOtheruserDetails(
          event.basicUserId, ProfileActivationStatus.Verified);

      if (result.status == AppConstants.SUCCESS) {
        this.profileDetails = result.profileDetails;
        if (this.religion == null) {
          var religionName = this.profileDetails!.religion;
          var religionId = this.profileDetails!.religionId;
          this.religion = SimpleMasterData(religionId, religionName);
        }
        if (this.motherTongue == null) {
          var motherTongueName = this.profileDetails!.motherTongue;
          var motherTongueId = this.profileDetails!.motherTongueId;
          this.motherTongue =
              SimpleMasterData(motherTongueId, motherTongueName);
        }
        if (this.gothra == null || this.gothra == "") {
          this.gothra = this.profileDetails!.gothra;
        }
        this.isManglik = this.profileDetails!.manglik;

        if (this.subCaste == null || this.subCaste == "") {
          this.subCaste = this.profileDetails!.cast;
        }
        yield ReligionDetailsState(result.profileDetails);
      } else {
        yield OnError(result.message);
      }
    }

    if (event is GetUserReligionMasterData) {
      var result = await this.userRepository.getMasterData();
      if (result.status == AppConstants.SUCCESS) {
        this.userRepository.masterData = result.data!;
        yield ReligionInitialState();
      }
    }
    if (event is OnReligionSelected) {
      if (this.religion == null) {
        this.religion = event.religion;
      } else {
        prevReligion = this.religion;
        this.religion = event.religion;
        if (prevReligion != this.religion) {
          this.subCaste = null;
          this.cast = CastSubCast("", []);
          this.gothra = "";
        }
      }
      if (this.religion!.title.toLowerCase().contains("hindu")) {
        this.isManglik = Manglik.NotApplicable;
        this.gothra = "";
      }
      yield ReligionInitialState();
    }
    if (event is OnCastSelected) {
      this.cast = event.cast;
      yield ReligionInitialState();
    }
    if (event is OnSubCastSelected) {
      this.subCaste = event.subCast;
      yield ReligionInitialState();
    }
    if (event is OnMotherTongueSelected) {
      this.motherTongue = event.motherTongue;
      yield ReligionInitialState();
    }
    if (event is OnGothraSelected) {
      this.gothra = event.gothra;
      yield ReligionInitialState();
    }
    if (event is OnMaglikChanged) {
      this.isManglik = event.value;
      yield ReligionInitialState();
    }
    if (event is UpdateReligion) {
      this.motherTongue = event.motherTongue;
      this.gothra = event.gothra;
      this.isManglik = event.isManglik;
      this.religion = event.religion;
      this.subCaste = event.subcast;

      if (this.motherTongue == null &&
          this.gothra == null &&
          this.religion == null &&
          this.subCaste == "") {
        yield OnError('Please enter all mandatory details');
      }
      if (this.religion == null) {
        yield OnError("Please select religion");
      } else if (!casteNotAvailable() && this.subCaste == '') {
        yield OnError("Please select sub-caste");
      } else if (this.motherTongue == null) {
        yield OnError("Please select mother tongue");
      } else if (this.subCaste == null) {
        yield OnError("Please select Caste");
      } else if (this.religion!.title.toLowerCase().contains("hindu") &&
          (this.gothra == null || this.gothra.isEmpty)) {
        yield OnError("Please select Gothra");
      } else if (this.religion!.title.toLowerCase().contains("hindu") &&
          (this.isManglik == Manglik.NotApplicable)) {
        yield OnError("Please choose Manglik Status.");
      } else {

        var result = await this.userRepository.updateReligion(this.religion!,
            this.subCaste, this.motherTongue!, this.gothra, this.isManglik);

        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails!.religion = this.religion!;
          this.userRepository.useDetails!.motherTongue = this.motherTongue!;
          this.userRepository.useDetails!.registrationStep =
              result.userDetails!.registrationStep;
          await this
              .userRepository
              .storageService
              .saveUserDetails(this.userRepository.useDetails!);
          if (!event.isAnUpdate) {
            await this
                .userRepository
                .updateRegistartionStep(this.userRepository.useDetails!.id, 4);
            this.userRepository.updateRegistrationStep(4);
          }
          yield event.isAnUpdate ? OnNavigationToMyProfiles() : MoveToCarrer();
        } else {
          yield OnError(result.message);
        }
      }
    }
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
