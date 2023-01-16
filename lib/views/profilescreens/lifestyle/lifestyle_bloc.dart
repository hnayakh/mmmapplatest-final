import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profilescreens/lifestyle/lifestyle_details_view.dart';
import 'package:makemymarry/views/profilescreens/lifestyle/lifestyle_event.dart';
import 'package:makemymarry/views/profilescreens/lifestyle/lifestyle_state.dart';

import '../../../repo/user_repo.dart';

class LifeStyleBloc extends Bloc<LifeStyleEvent, LifeStyleState> {
  final UserRepository userRepository;
  LifeStyleBloc({required this.userRepository})
      : super(LifeStyleInitialState()) {
    loadLifeStyleData();
  }

  loadLifeStyleData() {
    add(LoadLifeCycleData());
  }

  @override
  Stream<LifeStyleState> mapEventToState(LifeStyleEvent event) async* {
    // yield LifeStyleLoadingState();
    if (event is LoadLifeCycleData) {
      var data = await userRepository.getOtheruserDetails(
          userRepository.useDetails!.id, ProfileActivationStatus.Verified);

      var lifeStyle = LifeStyleData(
        openToPets: data.profileDetails.lifeStyle
                ?.contains(LifeStyleType.openToPets.name) ??
            false,
        ownsCar: data.profileDetails.lifeStyle
                ?.contains(LifeStyleType.ownsCar.name) ??
            false,
        ownsBusiness: data.profileDetails.lifeStyle
                ?.contains(LifeStyleType.ownsBusiness.name) ??
            false,
        ownsHouse: data.profileDetails.lifeStyle
                ?.contains(LifeStyleType.ownsHouse.name) ??
            false,
        ownsTwoWheeler: data.profileDetails.lifeStyle
                ?.contains(LifeStyleType.ownsBike.name) ??
            false,
        haveOther: data.profileDetails.lifeStyle
                ?.contains(LifeStyleType.haveOthers.name) ??
            false,
      );
      yield LifeStyleIdleState(data: lifeStyle);
    }
    if (event is LifeStyleToggled) {
      var data = event.type.toggle(event.data);
      yield LifeStyleIdleState(data: data);
    }
    if (event is SaveLifeStyleData) {
      var data = ( state as LifeStyleIdleState).data;
      yield LifeStyleLoadingState();
      var lifeStyle = <String>[];
      if (data.openToPets) {
        lifeStyle.add(LifeStyleType.openToPets.name);
      }
      if (data.ownsTwoWheeler) {
        lifeStyle.add(LifeStyleType.ownsBike.name);
      }
      if (data.ownsCar) {
        lifeStyle.add(LifeStyleType.ownsCar.name);
      }
      if (data.ownsBusiness) {
        lifeStyle.add(LifeStyleType.ownsBusiness.name);
      }
      if (data.ownsHouse) {
        lifeStyle.add(LifeStyleType.ownsHouse.name);
      }
      if (data.haveOther) {
        lifeStyle.add(LifeStyleType.haveOthers.name);
      }
      var xdata = await userRepository.updateLifeStyle(
          userRepository.useDetails!.id, lifeStyle);
      if (userRepository.useDetails!.registrationStep > 8) {
        yield NavigateToMyProfile();
      }
    }
  }
}
