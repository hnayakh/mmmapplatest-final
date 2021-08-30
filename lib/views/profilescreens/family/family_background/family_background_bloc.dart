import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/family_background_event.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/family_background_state.dart';

class FamilyBackgroundBloc
    extends Bloc<FamilyBackgroundEvent, FamilyBackgroundState> {
  final UserRepository userRepository;

  FamilyAfluenceLevel? level;
  FamilyValues? values;
  FamilyType type = FamilyType.Nuclear;
  CountryModel? countryModel;
  StateModel? myState, city;

  FamilyBackgroundBloc(this.userRepository)
      : super(FamilyBackgroundInitialState());

  @override
  Stream<FamilyBackgroundState> mapEventToState(
      FamilyBackgroundEvent event) async* {
    yield OnLoading();
    if (event is OnFamilyStatusSelected) {
      this.level = event.level;
      yield FamilyBackgroundState();
    }
    if (event is OnFamilyValueSelected) {
      this.values = event.value;
      yield FamilyBackgroundState();
    }
    if (event is OnFamilyTypeChanges) {
      this.type = event.familyType;
      yield FamilyBackgroundState();
    }
    if (event is OnCountrySelected) {
      this.countryModel = event.countryModel;
      yield FamilyBackgroundState();
    }
    if (event is OnStateSelected) {
      this.myState = event.stateModel;
      yield FamilyBackgroundState();
    }
    if (event is OnCitySelected) {
      this.city = event.stateModel;
      yield FamilyBackgroundState();
    }
    if (event is GetAllCountries) {
      var result = await this.userRepository.getCountries();
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotCounties(result.list);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is GetAllStates) {
      var result = await this.userRepository.getStates(this.countryModel!.id);
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotStates(result.list);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is GetAllCities) {
      var result = await this.userRepository.getCities(this.myState!.id);
      if (result.status == AppConstants.SUCCESS) {
        yield OnGotCities(result.list);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is UpdateFamilyBackground) {
      if (this.level == null) {
        yield OnError("Select Family Status");
      } else if (this.values == null) {
        yield OnError("Select Family Values");
      } else if (this.countryModel == null) {
        yield OnError("Select Country");
      } else if (myState == null) {
        yield OnError("Select State");
      } else if (city == null) {
        yield OnError("Select City");
      } else {
        var result = await this.userRepository.updateFamilyBackground(
            this.level!,
            this.values!,
            this.type,
            this.countryModel!,
            this.myState!,
            this.city!);
        if (result.status == AppConstants.SUCCESS) {
          yield OnUpdate();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
