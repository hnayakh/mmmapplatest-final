import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

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
  ProfileDetails? profileDetails;

  @override
  Stream<HabitState> mapEventToState(HabitEvent event) async* {
    yield OnLoading();
    if (event is onHabitDataLoad) {
      var result = await this.userRepository.getOtheruserDetails(
          event.basicUserId, ProfileActivationStatus.Verified);

      if (result.status == AppConstants.SUCCESS) {
        this.profileDetails = result.profileDetails;
        yield HabitDetailsState(result.profileDetails);
      } else {
        yield OnError(result.message);
      }
    }
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
      this.eatingHabit = event.eatingHabit;
      this.drinkingHabit = event.drinkingHabit;
      this.smokingHabit = event.smokingHabit;
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
          this.userRepository.updateRegistrationStep(7);
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
