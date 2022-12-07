import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class VerifyEvent extends BaseEventState {}

class OnSelectIdProof extends VerifyEvent {
  late final IdProofType idProof;
  OnSelectIdProof(this.idProof);
}

class AddDocumentImage extends VerifyEvent {
  final String docImages;

  AddDocumentImage(this.docImages);
}

class IdVerificationEvent extends VerifyEvent {
  final String image;
  IdVerificationEvent(this.image);
}
