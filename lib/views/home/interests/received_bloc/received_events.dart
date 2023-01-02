import 'package:makemymarry/base_event_state.dart';

class ReceivedEvents extends BaseEventState {}

class RejectInterestEvent extends ReceivedEvents {
  final int index;

  RejectInterestEvent(this.index);
}

class AcceptInterestEvent extends ReceivedEvents {
  final int index;

  AcceptInterestEvent(this.index);
}

class CheckListisEmpty extends ReceivedEvents {}
