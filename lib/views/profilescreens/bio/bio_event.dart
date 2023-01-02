import 'package:makemymarry/base_event_state.dart';

class BioEvent extends BaseEventState {}

class AddImage extends BioEvent {
  final String images;

  AddImage(this.images);
}

class RemoveImage extends BioEvent {
  final int pos;

  RemoveImage(this.pos);
}

class UpdateBio extends BioEvent {
  final String bio;
  final List<String> localImagePaths;
  UpdateBio(this.bio, this.localImagePaths);
}

class UpdateBioText extends BioEvent {
  final String bio;

  UpdateBioText(this.bio);
}

class UpdateBioImage extends BioEvent {
  final List<String> localImagePaths;
  UpdateBioImage(this.localImagePaths);
}

class FetchMyImage extends BioEvent {}

class onBioDataLoad extends BioEvent {
  final String basicUserId;

  onBioDataLoad(this.basicUserId);
}
