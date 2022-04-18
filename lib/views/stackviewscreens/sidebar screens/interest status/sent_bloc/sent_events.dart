import 'package:makemymarry/bloc/base_event_state.dart';

class SentEvents extends BaseEventState {}

class CancelSentInterest extends SentEvents {
  final int index;

  CancelSentInterest(this.index);
}

class CheckSentListIsEmpty extends SentEvents {}
