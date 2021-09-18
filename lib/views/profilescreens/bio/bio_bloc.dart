import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

import 'bio_event.dart';
import 'bio_state.dart';

class BioBloc extends Bloc<BioEvent, BioState> {
  final UserRepository userRepository;

  BioBloc(this.userRepository) : super(BioInitialState());
  List<String> localImagePaths = [];

  @override
  Stream<BioState> mapEventToState(BioEvent event) async* {
    yield OnLoading();
    if (event is AddImage) {
      this.localImagePaths.add(event.images);
      yield BioInitialState();
    }
    if(event is RemoveImage){
      this.localImagePaths.removeAt(event.pos);
      yield BioInitialState();
    }
  }
}
