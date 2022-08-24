import 'package:flutter_bloc/flutter_bloc.dart';
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
  CastSubCast? cast;
  SimpleMasterData? motherTongue;
  dynamic gothra = "";
  Manglik isManglik = Manglik.NotApplicable;

  SimpleMasterData? prevReligion;

  ReligionBloc(this.userRepository) : super(ReligionInitialState());

  @override
  Stream<ReligionState> mapEventToState(ReligionEvent event) async* {
    yield OnReligionLoading();

    if (event is OnReligionSelected) {
      if (this.religion == null) {
        this.religion = event.religion;
      } else {
        prevReligion = this.religion;
        this.religion = event.religion;
        if (prevReligion != this.religion) {
          this.subCaste = null;
          this.cast = null;
          this.motherTongue = null;
          this.gothra = "";
        }
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
      if (this.religion == null) {
        yield OnError("Please select religion");
      } else if (!casteNotAvailable() && this.subCaste == null) {
        yield OnError("Please select ub-caste");
      } else if (this.motherTongue == null) {
        yield OnError("Please select mother tongue");
      }
      // else if (this.religion!.title.toLowerCase().contains("hindu") &&
      //     this.gothra == null) {
      //   yield OnError("Please select Gothra");
      // }
      else {
        var result = await this.userRepository.updateReligion(this.religion!,
            this.subCaste, this.motherTongue!, this.gothra, this.isManglik);

        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails!.religion = this.religion!;
          this.userRepository.useDetails!.motherTongue = this.motherTongue!;
          this.userRepository.useDetails!.registrationStep =
              result.userDetails!.registrationStep;
          //await this.userRepository.saveUserDetails();
          await this
              .userRepository
              .storageService
              .saveUserDetails(this.userRepository.useDetails!);
          this.userRepository.updateRegistrationStep(5);
          print('in religion');
          print(
              'dobinreligionbloc=${this.userRepository.useDetails!.dateOfBirth}');
          print(this.userRepository.useDetails!.registrationStep);
          yield MoveToCarrer();
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
