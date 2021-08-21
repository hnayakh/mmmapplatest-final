import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

import 'habit_event.dart';
import 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  late final UserRepository userRepository;
  HabitBloc(this.userRepository) : super(HabitInitialState());
  late EatingHabit eatingHabit;
  late DrinkingHabit drinkingHabit;
  late SmokingHabit smokingHabit;
  @override
  Stream<HabitState> mapEventToState(HabitEvent event) async* {
    yield OnLoading();
    if (event is EatingHabitSelected) {
      this.eatingHabit = event.eatingHabit;
      yield HabitInitialState();
    }
    if (event is DrinkingHabitSelected) {
      this.drinkingHabit = event.drinkingHabit;
      yield HabitInitialState();
    }
    if (event is SmokingHabitSelected) {
      this.smokingHabit = event.smokingHabit;
      yield HabitInitialState();
    }
    if (event is OnNavigateToReligion) {
      this.eatingHabit = event.eatingHabit;
      this.drinkingHabit = event.drinkingHabit;
      this.smokingHabit = event.smokingHabit;
      if (this.eatingHabit == 0) {
        yield OnError('Select eating habit.');
      } else if (this.drinkingHabit == 0) {
        yield OnError('Select drinking habit.');
      } else if (this.smokingHabit == 0) {
        yield OnError('Select smoking habit.');
      } else {
        var result = await this.userRepository.habit(
              this.eatingHabit,
              this.smokingHabit,
              this.drinkingHabit,
            );

        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails = result.userDetails;
          await this.userRepository.saveUserDetails();
          yield NavigationToReligion();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
