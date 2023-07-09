import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_event.dart';
import 'package:makemymarry/views/stackviewscreens/sidebar%20screens/profile%20screens/verify%20account%20screens/verify_state.dart';
import 'package:table_calendar/table_calendar.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  late final UserRepository userRepository;
  IdProofType? idProof;
  List<String> localDocImagePaths = [];
  ProfileDetails? profileData;

  VerifyBloc(this.userRepository) : super(VerifyInitialState()){

    add(GetPreviousDocs());
  }

  @override
  Stream<VerifyState> mapEventToState(VerifyEvent event) async* {
    yield OnLoading();
    if (event is GetPreviousDocs) {
      var res = await userRepository.getOtheruserDetails(
          userRepository.useDetails!.id, ProfileActivationStatus.Verified);

      if (res.profileDetails.docUpdationStatus != '-1') {
        localDocImagePaths.clear();
        print("length after clear${localDocImagePaths.length}");
        //..clear()
        if (res.profileDetails.docUrl != "") {
          localDocImagePaths.add(res.profileDetails.docUrl);
        }
        idProof = res.profileDetails.docType;
      }
      yield VerifyInitialState();
    }
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
        this.localDocImagePaths.clear();
        this.localDocImagePaths.add(result);
        yield VerifyInitialState();
      } else {
        yield OnError('Could not upload document');
      }
    }
    if (event is RemoveDocImage) {
      print("position${event.pos}");
      this.localDocImagePaths.removeAt(event.pos);
      this.localDocImagePaths
        ..clear()
        ..add("");
      var result = await this
          .userRepository
          .updateDoc(idProof!, this.localDocImagePaths);

      if (result.status == AppConstants.SUCCESS) {
        yield OnUpdateDoc(result.message);
      } else {
        yield OnError(result.message);
      }
      yield VerifyInitialState();
    }

    if (event is UpdateDoc) {
      if (this.idProof == null && this.localDocImagePaths.length == 0) {
        yield OnError("Please enter all data");
      }
      if (this.idProof == null) {
        yield OnError("Please select the ID Proof type");
      }
      if (this.localDocImagePaths.length == 0) {
        yield OnError("Please pick an image as ID Proof");
      }
      this.idProof = event.idProof;
      this.localDocImagePaths = event.localDocImagePaths;

      var result =
          await this.userRepository.updateDoc(idProof!, localDocImagePaths);

      if (result.status == AppConstants.SUCCESS) {
        yield OnUpdateDoc(result.message);
      } else {
        yield OnError(result.message);
      }
    }
  }
}
