import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profilescreens/hobbies/hobby_details_view.dart';

import '../../../repo/user_repo.dart';
import 'hobby_event.dart';
import 'hobby_state.dart';

class HobbyBloc extends Bloc<HobbyEvent, HobbyState> {
  final UserRepository userRepository;
  HobbyBloc({required this.userRepository}) : super(HobbyInitialState()) {
    loadHobbyData();
  }

  loadHobbyData() {
    add(LoadHobbyData());
  }

  @override
  Stream<HobbyState> mapEventToState(HobbyEvent event) async* {

    if (event is LoadHobbyData) {
      var data = await userRepository.getOtheruserDetails(
          userRepository.useDetails!.id, ProfileActivationStatus.Verified);

      var hobbies = <HobbyType>[];
      data.profileDetails.hobbies?.forEach((hobby) {
        hobbies.add(
            HobbyType.values.firstWhere((element) => element.name == hobby));
      });

      yield HobbyIdleState(data: HobbyData(hobbies: hobbies));
    }
    if (event is HobbyToggled) {
      var data = event.type.toggle(event.data);
      yield HobbyIdleState(data: data);
    }
    if (event is SaveHobbyData) {
      var data = (state as HobbyIdleState).data;
      yield HobbyLoadingState();
      var hobbies = <String>[];
      data.hobbies.forEach((element) {
        hobbies.add(element.name);
      });
      await userRepository.updateHobby(
          userRepository.useDetails!.id, hobbies);
      if (userRepository.useDetails!.registrationStep > 8) {
        yield NavigateToMyProfile();
      }
    }
  }
}
