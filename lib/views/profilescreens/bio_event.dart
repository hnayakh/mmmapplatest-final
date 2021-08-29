import 'package:makemymarry/bloc/base_event_state.dart';

class BioEvent extends BaseEventState {}

class UpdateBioEvent extends BioEvent {
  final String aboutMe;
  final String imageUrl1;
  final String imageUrl2;
  final String imageUrl3;
  final String imageUrl4;
  UpdateBioEvent(this.aboutMe, this.imageUrl1, this.imageUrl2, this.imageUrl3,
      this.imageUrl4);
}
