import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/master_data.dart';

class FamilyBackgroundState extends BaseEventState{

}
class OnLoading extends FamilyBackgroundState{

}
class OnError extends FamilyBackgroundState{
  final String message;

  OnError(this.message);
}
class FamilyBackgroundInitialState extends FamilyBackgroundState{

}
class OnUpdate extends FamilyBackgroundState{

}
class OnGotCounties extends FamilyBackgroundState{
  final List<CountryModel> list;

  OnGotCounties(this.list);
}
class OnGotCities extends FamilyBackgroundState{
  final List<StateModel> list;

  OnGotCities(this.list);
}
class OnGotStates extends FamilyBackgroundState{
  final List<StateModel> list;

  OnGotStates(this.list);
}