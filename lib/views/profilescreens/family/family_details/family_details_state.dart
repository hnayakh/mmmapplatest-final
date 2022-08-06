import 'package:makemymarry/bloc/base_event_state.dart';

class FamilyDetailState extends BaseEventState {}

class FamilyDetailInitialState extends FamilyDetailState {}

class OnLoading extends FamilyDetailState {}

class OnError extends FamilyDetailState {
  final String message;

  OnError(this.message);
}

class OnFamilyDetailsUpdated extends FamilyDetailState {}
