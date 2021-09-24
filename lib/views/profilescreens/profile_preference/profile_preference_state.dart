import 'package:makemymarry/bloc/base_event_state.dart';

class ProfilePreferenceState extends BaseEventState{

}
class ProfilePreferenceInitialState extends ProfilePreferenceState{

}
class OnLoading extends ProfilePreferenceState{

}
class OnError extends ProfilePreferenceState{
  final String message;

  OnError(this.message);
}
class OnUpdate extends ProfilePreferenceState{

}