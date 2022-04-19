import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

import 'interest_events.dart';
import 'interest_states.dart';


class InterestsBloc extends Bloc<InterestEvents, InterestStates> {
  late final UserRepository userRepository;
  late List<ActiveInterests> listSent = []; //sent
  late List<ActiveInterests> listConnections = []; //accepted
  late List<ActiveInterests> listInvites = []; //received

  InterestsBloc(this.userRepository) : super(InterestInitialState());

  @override
  Stream<InterestStates> mapEventToState(InterestEvents event) async* {
    yield OnLoading();
    if (event is GetListOfInterests) {
      print(userRepository.useDetails!.id);
      var result = await this
          .userRepository
          .getInterestList(this.userRepository.useDetails!.id);
      if (result.status == AppConstants.SUCCESS) {
        this.listSent = result.data.activeSent;
        this.listConnections = result.data.activeconnections;
        this.listInvites = result.data.activeInvites;
        yield OnGotInterestLists();
      } else {
        yield OnError(result.message);
      }
    }
  }
}
