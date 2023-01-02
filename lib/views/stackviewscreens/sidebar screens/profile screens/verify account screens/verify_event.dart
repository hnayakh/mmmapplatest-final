import 'package:makemymarry/base_event_state.dart';
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

class RemoveDocImage extends VerifyEvent {
  final int pos;

  RemoveDocImage(this.pos);
}

class UpdateDoc extends VerifyEvent {
  final IdProofType idProof;
  final List<String> localDocImagePaths;
  UpdateDoc(this.idProof, this.localDocImagePaths);
}

class IdVerificationEvent extends VerifyEvent {
  final String image;
  IdVerificationEvent(this.image);
}
