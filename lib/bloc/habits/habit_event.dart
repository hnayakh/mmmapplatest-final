import 'package:makemymarry/bloc/base_event_state.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class HabitEvent extends BaseEventState {}

class EatingHabitSelected extends HabitEvent {
  late final EatingHabit eatingHabit;
  EatingHabitSelected(this.eatingHabit);
}

class SmokingHabitSelected extends HabitEvent {
  late final SmokingHabit smokingHabit;
  SmokingHabitSelected(this.smokingHabit);
}

class DrinkingHabitSelected extends HabitEvent {
  late final DrinkingHabit drinkingHabit;
  DrinkingHabitSelected(this.drinkingHabit);
}

class OnNavigateToReligion extends HabitEvent {
  late final EatingHabit eatingHabit;
  late final SmokingHabit smokingHabit;
  late final DrinkingHabit drinkingHabit;
  OnNavigateToReligion(this.eatingHabit, this.smokingHabit, this.drinkingHabit);
}

class UpdateHabit extends HabitEvent {
  late final EatingHabit eatingHabit;
  late final SmokingHabit smokingHabit;
  late final DrinkingHabit drinkingHabit;
  bool isAnUpdate;

  UpdateHabit(
      this.eatingHabit, this.drinkingHabit, this.smokingHabit, this.isAnUpdate);
}

class onHabitDataLoad extends HabitEvent {
  final String basicUserId;

  onHabitDataLoad(this.basicUserId);
}
