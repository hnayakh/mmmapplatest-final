import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

import 'bio_event.dart';
import 'bio_state.dart';

class BioBloc extends Bloc<BioEvent, BioState> {
  final UserRepository userRepository;
  ProfileDetails? profileData;
  BioBloc(this.userRepository) : super(BioInitialState());
  List<String> localImagePaths = [];
  String aboutMeMsg = "";

  @override
  Stream<BioState> mapEventToState(BioEvent event) async* {
    yield OnLoading();

    if (event is onBioDataLoad) {
      var result = await this.userRepository.getOtheruserDetails(
          event.basicUserId, ProfileActivationStatus.Verified);

      if (result.status == AppConstants.SUCCESS) {
        this.profileData = result.profileDetails;
        yield BioDataState(result.profileDetails);
      } else {
        yield OnError(result.message);
      }
    }

    if (event is UpdateBio) {
      this.aboutMeMsg = event.bio;
      this.localImagePaths = event.localImagePaths;
      if (this.aboutMeMsg == null && this.localImagePaths.length == 0) {
        yield OnError("please enter all mandatory details");
      }
      if (this.aboutMeMsg == null) {
        yield OnError("Enter Bio");
      } else if (this.localImagePaths == null) {
        yield OnError("Add Images");
      } else {
        var result = await this
            .userRepository
            .updateBio(event.bio, this.localImagePaths);
        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails!.registrationStep = 8;
          //await this.userRepository.saveUserDetails();
          await this
              .userRepository
              .storageService
              .saveUserDetails(this.userRepository.useDetails!);
          this.userRepository.updateRegistrationStep(8);

          yield OnUpdate();
        } else {
          yield OnError(result.message);
        }
      }
    }
    if (event is AddImage) {
      print("saurabh uplaod 2");

      var result = await this.userRepository.uploadImage(event.images);
      if (result != null) {
        this.localImagePaths.add(result);
        yield BioInitialState();
      } else {
        yield OnError('Couldnot upload image');
      }

      // var imageName = this.userRepository.useDetails!.id +
      //     "_" +
      //     DateTime.now().microsecondsSinceEpoch.toString() +
      //     ".png";
      // var result = await this.userRepository.uploadImage(event.images);
      // if (result.status == AppConstants.SUCCESS) {
      //   var response = await this
      //       .userRepository
      //       .uploadFile(result.imageUrl!, imageName, event.images);
      //   if (response != null) {
      //     if (response.statusCode == 200 || response.statusCode == 201) {
      //       this
      //           .localImagePaths
      //           .add(AppConstants.PUBLICIMAGEBASEURL + imageName);
      //       yield BioInitialState();
      //     }
      //   }
      // }
    }
    if (event is RemoveImage) {
      this.localImagePaths.removeAt(event.pos);
      yield BioInitialState();
    }
    if (event is FetchMyImage) {
      var response = await this.userRepository.getOtheruserDetails(
          userRepository.useDetails!.id,
          ProfileActivationStatus
              .values[userRepository.useDetails!.activationStatus]);
      print('saurabh 1${response.profileDetails.images}');
      print('Akash123${response.profileDetails}');

      print(response);
      if (response.status == AppConstants.SUCCESS) {
        this.profileData = response.profileDetails;
        this.aboutMeMsg = response.profileDetails.aboutMe;
        print('ABOUT 2${this.aboutMeMsg}');
        yield OnGotProfileandImages(this.profileData!);
      } else {
        print('etywgfyuegtwqyuetwqetwquyteuywqteuy');
        print(response);
        yield OnError(response.message);
      }
    }
  }
}
