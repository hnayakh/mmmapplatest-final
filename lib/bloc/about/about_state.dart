import 'package:makemymarry/bloc/base_event_state.dart';

class AboutState extends BaseEventState {}

class AboutInitialState extends AboutState {}

class OnLoading extends AboutState {}

class OnError extends AboutState {
  final String message;

  OnError(this.message);
}

class OnNavigationToHabits extends AboutState {}
