import 'package:makemymarry/bloc/base_event_state.dart';

class BioEvent extends BaseEventState {}

class AddImage extends BioEvent {
  final String images;

  AddImage(this.images);
}
class RemoveImage extends BioEvent{
  final int pos;

  RemoveImage(this.pos);
}
class UpdateBio extends BioEvent{
  final String bio;

  UpdateBio(this.bio);
}