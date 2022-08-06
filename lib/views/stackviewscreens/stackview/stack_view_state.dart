import 'package:makemymarry/bloc/base_event_state.dart';

class StackViewState extends BaseEventState {}

class OnError extends StackViewState {
  final String message;
  OnError(this.message);
}

class StackViewInitialState extends StackViewState {}

class OnLoading extends StackViewState {}
