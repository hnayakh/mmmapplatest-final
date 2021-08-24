import 'package:makemymarry/bloc/base_event_state.dart';

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