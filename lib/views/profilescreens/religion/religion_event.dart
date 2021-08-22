import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/master_data.dart';

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
  final SimpleMasterData subCast;

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
class OnMaglikChanged extends ReligionEvent{
  final int value;

  OnMaglikChanged(this.value);
}
class UpdateReligion extends ReligionEvent{

}