import 'package:makemymarry/base_event_state.dart';

import 'hobby_details_view.dart';

class HobbyEvent extends BaseEventState {}

class LoadHobbyData extends HobbyEvent {}

class SaveHobbyData extends HobbyEvent {}


class HobbyToggled extends HobbyEvent {
  final HobbyData data;
  final HobbyType type;

  HobbyToggled(this.data, this.type);
}

class HobbyData {
  final List<HobbyType> hobbies;

  const HobbyData({
    required this.hobbies,
  });

  HobbyData copyWith({
    List<HobbyType>? hobbies,
  }) =>
      HobbyData(hobbies: hobbies ?? this.hobbies);
}
