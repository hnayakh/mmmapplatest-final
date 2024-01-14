import 'package:makemymarry/base_event_state.dart';

class ProfileViewEvent extends BaseEventState {}

class VisitProfile extends ProfileViewEvent {}

class GetProfileViewDetails extends ProfileViewEvent {
  final String displayId;
  GetProfileViewDetails(this.displayId);
}


class SendLikeRequest extends ProfileViewEvent {}

class BlockProfile extends ProfileViewEvent {}

class UnBlockProfile extends ProfileViewEvent {}

class CancelLikeRequest extends ProfileViewEvent {}

class AcceptLikeRequest extends ProfileViewEvent {}

class RejectLikeRequest extends ProfileViewEvent {}

class MakeConnectRequest extends ProfileViewEvent {}
