import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

class BioState extends BaseEventState {}

class OnProfileSetupCompletion extends BioState {}

class OnError extends BioState {
  final String message;
  OnError(this.message);
}

class BioInitialState extends BioState {}

class OnLoading extends BioState {}

class OnUpdate extends BioState {}

class OnGotProfileandImages extends BioState {
  final ProfileDetails profileDetails;
  OnGotProfileandImages(this.profileDetails);
}

class BioDataState extends BioState {
  final ProfileDetails profileDetails;
  BioDataState(this.profileDetails);
}
