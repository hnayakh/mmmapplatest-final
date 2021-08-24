import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

import 'religion_event.dart';
import 'religion_state.dart';

class ReligionBloc extends Bloc<ReligionEvent, ReligionState> {
  final UserRepository userRepository;

  SimpleMasterData? religion;
  dynamic subCaste;
  CastSubCast? cast;
  SimpleMasterData? motherTongue;
  dynamic gothra;
  bool isManglik = false;

  ReligionBloc(this.userRepository) : super(ReligionInitialState());

  @override
  Stream<ReligionState> mapEventToState(ReligionEvent event) async* {
    yield OnReligionLoading();

    if (event is OnReligionSelected) {
      this.religion = event.religion;
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
      this.isManglik = event.value == 1;
      yield ReligionInitialState();
    }
    if (event is UpdateReligion) {
      if (this.religion == null) {
        yield OnError("Please select religion");
      } else if (this.cast == null) {
        yield OnError("Please select caste");
      } else if (this.subCaste == null) {
        yield OnError("Please select sub-caste");
      } else if (this.motherTongue == null) {
        yield OnError("Please select mother tongue");
      } else if (this.religion!.title.toLowerCase().contains("hindu") &&
          this.gothra == null) {
        yield OnError("Please select Gothra");
      } else {
        var result = await this.userRepository.updateReligion(
            this.religion!,
            this.cast!.cast,
            this.subCaste,
            this.motherTongue!,
            this.gothra,
            this.isManglik);

        if (result.status == AppConstants.SUCCESS) {
          // this.userRepository.useDetails = result.userDetails;
          // await this.userRepository.saveUserDetails();
          yield MoveToCarrer();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
