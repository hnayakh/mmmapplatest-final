import 'package:makemymarry/base_event_state.dart';

class AcceptedEvents extends BaseEventState {}

class CheckAcceptedListIsEmpty extends AcceptedEvents {}

class ConnectNow extends AcceptedEvents {
  final String userId;

  ConnectNow(this.userId);
}
