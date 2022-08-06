import 'package:makemymarry/bloc/base_event_state.dart';

class SentEvents extends BaseEventState {}

class CancelSentInterest extends SentEvents {
  final int index;

  CancelSentInterest(this.index);
}

class CheckSentListIsEmpty extends SentEvents {}

class ConnectNow extends SentEvents {
  final String connectById, connectToId;

  ConnectNow({required this.connectById, required this.connectToId});
}
