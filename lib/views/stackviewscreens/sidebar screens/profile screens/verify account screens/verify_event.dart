import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class VerifyEvent extends BaseEventState {}

class OnSelectIdProof extends VerifyEvent {
  late final IdProofType idProof;
  OnSelectIdProof(this.idProof);
}

class IdVerificationEvent extends VerifyEvent {}
