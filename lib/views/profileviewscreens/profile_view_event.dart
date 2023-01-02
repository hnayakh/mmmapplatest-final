import 'package:makemymarry/base_event_state.dart';

class ProfileViewEvent extends BaseEventState {}

class VisitProfile extends ProfileViewEvent {}

class GetProfileViewDetails extends ProfileViewEvent {
  final String displayId;
  GetProfileViewDetails(this.displayId);
}
