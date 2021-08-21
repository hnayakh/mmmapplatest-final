import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';

import 'religion_event.dart';
import 'religion_state.dart';

class ReligionBloc extends Bloc<ReligionEvent, ReligionState> {
  final UserRepository userRepository;

  SimpleMasterData? religion;
  SimpleMasterData? subCaste;
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
    if (event is UpdateReligion) {}
  }
}
