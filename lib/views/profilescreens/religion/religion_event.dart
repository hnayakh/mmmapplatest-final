import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class ReligionEvent extends BaseEventState {}

class OnReligionSelected extends ReligionEvent {
  final SimpleMasterData religion;

  OnReligionSelected(this.religion);
}

class OnCastSelected extends ReligionEvent {
  final CastSubCast cast;

  OnCastSelected(this.cast);
}

class OnSubCastSelected extends ReligionEvent {
  final dynamic subCast;

  OnSubCastSelected(this.subCast);
}

class OnMotherTongueSelected extends ReligionEvent {
  final SimpleMasterData motherTongue;

  OnMotherTongueSelected(this.motherTongue);
}

class OnGothraSelected extends ReligionEvent {
  final dynamic gothra;

  OnGothraSelected(this.gothra);
}

class OnMaglikChanged extends ReligionEvent {
  final Manglik value;

  OnMaglikChanged(this.value);
}

class UpdateReligion extends ReligionEvent {
  final SimpleMasterData? motherTongue;
  final dynamic gothra;
  final Manglik isManglik;
  final SimpleMasterData? religion;
  final String subcast;

  UpdateReligion(this.motherTongue, this.gothra, this.isManglik, this.religion,
      this.subcast);
}

class onReligionDataLoad extends ReligionEvent {
  final String basicUserId;

  onReligionDataLoad(this.basicUserId);
}
