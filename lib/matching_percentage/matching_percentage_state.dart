import 'package:makemymarry/bloc/base_event_state.dart';

class MatchingPercentageState extends BaseEventState {}

class MatchingPercentageInitialState extends MatchingPercentageState {}

// class OnLoading extends MatchingPercentageState {}

class OnProfileVisited extends MatchingPercentageState {
  final int matchingPercentage;
  final String images;
  final List matchingFields;
  final List differentFields;
  final String name;

  OnProfileVisited(this.matchingPercentage, this.images, this.matchingFields,
      this.differentFields, this.name);
}

class OnError extends MatchingPercentageState {
  final String message;

  OnError(this.message);
}
