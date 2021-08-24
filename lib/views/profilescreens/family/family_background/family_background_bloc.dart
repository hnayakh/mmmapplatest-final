import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/family_background_event.dart';
import 'package:makemymarry/views/profilescreens/family/family_background/family_background_state.dart';

class FamilyBackgroundBloc
    extends Bloc<FamilyBackgroundEvent, FamilyBackgroundState> {
  final UserRepository userRepository;

  FamilyAfluenceLevel? level;
  FamilyValues? values;
  FamilyType type = FamilyType.Nuclear;

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
    if(event is OnFamilyValueSelected){
      this.values = event.value;
      yield FamilyBackgroundState();
    }
    if(event is OnFamilyTypeChanges){
      this.type = event.familyType;
      yield FamilyBackgroundState();
    }
  }
}
