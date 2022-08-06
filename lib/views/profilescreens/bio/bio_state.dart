import 'package:makemymarry/bloc/base_event_state.dart';

class BioState extends BaseEventState {}

class OnProfileSetupCompletion extends BioState {}

class OnError extends BioState {
  final String message;
  OnError(this.message);
}

class BioInitialState extends BioState {}

class OnLoading extends BioState {}
class OnUpdate extends BioState{

}