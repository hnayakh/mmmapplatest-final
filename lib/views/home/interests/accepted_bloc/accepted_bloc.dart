import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

import 'accepted_events.dart';
import 'accepted_states.dart';

class AcceptedsBloc extends Bloc<AcceptedEvents, AcceptedStates> {
  late final UserRepository userRepository;
  late List<ActiveInterests> listAccepted = []; //Accepted

  AcceptedsBloc(
    this.userRepository,
  ) : super(AcceptedInitialState());

  @override
  Stream<AcceptedStates> mapEventToState(AcceptedEvents event) async* {
    yield OnLoading();

    if (event is CheckAcceptedListisEmpty) {
      print(userRepository.useDetails!.id);
      var result = await this
          .userRepository
          .getInterestList(this.userRepository.useDetails!.id);
      if (result.status == AppConstants.SUCCESS) {
        this.listAccepted = result.data.activeconnections;
        print(listAccepted);
        if (this.listAccepted.length == 0) {
          yield AcceptedListIsEmptyState();
        } else {
          yield AcceptedListIsNotEmpty();
        }
      } else {
        yield OnError(result.message);
      }
    }
  }
}
