import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_event.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  late final UserRepository userRepository;
  IdProofType? idProof;
  List<String> localDocImagePaths = [];
  ProfileDetails? profileData;

  VerifyBloc(this.userRepository) : super(VerifyInitialState());

  @override
  Stream<VerifyState> mapEventToState(VerifyEvent event) async* {
    yield OnLoading();
    if (event is OnSelectIdProof) {
      this.idProof = event.idProof;
      yield VerifyInitialState();
    }

    if (event is AddDocumentImage) {
      var result = await this
          .userRepository
          .uploadDocImage(event.docImages, userRepository.useDetails!.id);
      print("result$result");
      if (result != null) {
        this.localDocImagePaths.add(result);
        yield VerifyInitialState();
      } else {
        yield OnError('Couldnot upload document');
      }

      //implement condition
    }
    if (event is RemoveDocImage) {
      this.localDocImagePaths.removeAt(event.pos);
      yield VerifyInitialState();
    }

    if (event is UpdateDoc) {
      this.idProof = event.idProof;
      this.localDocImagePaths = event.localDocImagePaths;

      var result =
          await this.userRepository.updateDoc(idProof!, localDocImagePaths);

      if (result.status == AppConstants.SUCCESS) {
        yield OnUpdateDoc();
      } else {
        yield OnError(result.message);
      }
    }
  }
}
