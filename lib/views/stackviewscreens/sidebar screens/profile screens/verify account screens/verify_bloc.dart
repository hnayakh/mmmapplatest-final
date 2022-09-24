import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_event.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  late final UserRepository userRepository;
  IdProofType? idProof;
  String docImage = '';

  VerifyBloc(this.userRepository) : super(VerifyInitialState());

  @override
  Stream<VerifyState> mapEventToState(VerifyEvent event) async* {
    yield OnLoading();
    if (event is OnSelectIdProof) {
      this.idProof = event.idProof;
      yield VerifyInitialState();
    }
    if (event is IdVerificationEvent) {
      var result = await this.userRepository.uploadDocument(event.image);
      if (result != null) {
        this.docImage = event.image;
        yield VerifyInitialState();
      } else {
        yield OnError('Couldnot upload document');
      }

      //implement condition
    }
  }
}
