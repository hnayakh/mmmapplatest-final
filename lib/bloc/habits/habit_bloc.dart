import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

import 'habit_event.dart';
import 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  late final UserRepository userRepository;

  HabitBloc(this.userRepository) : super(HabitInitialState());
  EatingHabit? eatingHabit;
  DrinkingHabit? drinkingHabit;
  SmokingHabit? smokingHabit;

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
    if (event is UpdateHabit) {
      if (this.eatingHabit == null &&
          this.drinkingHabit == null &&
          this.smokingHabit == null) {
        yield OnError('Select all habits');
      }
      if (this.eatingHabit == null) {
        yield OnError('Select eating habit.');
      } else if (this.drinkingHabit == null) {
        yield OnError('Select drinking habit.');
      } else if (this.smokingHabit == null) {
        yield OnError('Select smoking habit.');
      } else {
        var result = await this.userRepository.habit(
              this.eatingHabit!,
              this.smokingHabit!,
              this.drinkingHabit!,
            );

        if (result.status == AppConstants.SUCCESS) {
          //await this.userRepository.saveUserDetails();
          this.userRepository.useDetails!.registrationStep =
              result.userDetails!.registrationStep;
          await this
              .userRepository
              .storageService
              .saveUserDetails(this.userRepository.useDetails!);
          this.userRepository.updateRegistrationStep(4);
          print('in habit');
          print(
              'dobinhabitbloc=${this.userRepository.useDetails!.dateOfBirth}');
          print(this.userRepository.useDetails!.registrationStep);
          yield NavigationToReligion();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
