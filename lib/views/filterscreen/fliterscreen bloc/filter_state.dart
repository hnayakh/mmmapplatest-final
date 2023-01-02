import 'package:makemymarry/base_event_state.dart';

class FilterState extends BaseEventState {}

class FilterInitialState extends FilterState {}

class OnLoading extends FilterState {}

class OnError extends FilterState {
  final String message;

  OnError(this.message);
}

//class OnNavigationTo extends FilterState {}
