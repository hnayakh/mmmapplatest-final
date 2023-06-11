import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

import 'bio_event.dart';
import 'bio_state.dart';

class BioBloc extends Bloc<BioEvent, BioState> {
  final UserRepository userRepository;
  ProfileDetails? profileData;
  BioBloc(this.userRepository) : super(BioInitialState());
  List<String> localImagePaths = [];
  String aboutMeMsg = "";
  String profileImage = "";
  @override
  Stream<BioState> mapEventToState(BioEvent event) async* {
    yield OnLoading();

    if (event is onBioDataLoad) {
      var result = await this.userRepository.getOtheruserDetails(
          event.basicUserId, ProfileActivationStatus.Verified);

      if (result.status == AppConstants.SUCCESS) {
        this.profileData = result.profileDetails;
        profileImage = result.profileDetails.images.isNotNullEmpty ?  result.profileDetails.images.first : "";
        yield BioDataState(result.profileDetails);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is UpdateBioImage) {
      this.localImagePaths = event.localImagePaths;
      this.localImagePaths.removeWhere((element) => element == "addImage");

      this
          .localImagePaths
          .removeWhere((element) => element == this.profileImage);
      this.localImagePaths.insert(0, this.profileImage);

      if (this.localImagePaths.isEmpty) {
        yield OnError("Please add at least one Image");
      } else {
        var result = await this.userRepository.updateBio(
              this.profileData?.aboutmeMsg ?? "",
              this.localImagePaths,
            );
        if (result.status == AppConstants.SUCCESS) {
          if (!event.toUpdate) {
            this.userRepository.useDetails!.registrationStep = 8;
            this.userRepository.useDetails?.imageUrl =
                this.localImagePaths.first;
            await this
                .userRepository
                .storageService
                .saveUserDetails(this.userRepository.useDetails!);
            this.userRepository.updateRegistrationStep(8);
          }
          yield OnUpdate();
        } else {
          yield OnError(result.message);
        }
      }
    }

    if (event is UpdateBio) {
      this.aboutMeMsg = event.bio;
      this.localImagePaths = event.localImagePaths;
      if (this.aboutMeMsg.isEmpty && this.localImagePaths.length <= 1) {
        yield OnError("please enter all mandatory details");
      }
      if (this.aboutMeMsg.isEmpty) {
        yield OnError("Enter Bio");
      } else if (this.localImagePaths.length <= 1 && !event.toUpdate) {
        yield OnError("Please add at least one image");
      } else {
        var result = await this.userRepository.updateBio(
            event.bio,
            this
                .localImagePaths
                .where((element) => element != "addImage")
                .toList());
        if (result.status == AppConstants.SUCCESS) {
          if (!event.toUpdate) {
            this.userRepository.useDetails!.registrationStep = 8;
            this.userRepository.useDetails?.imageUrl = this
                .localImagePaths
                .where((element) => element != "addImage")
                .toList()
                .first;
            await this
                .userRepository
                .storageService
                .saveUserDetails(this.userRepository.useDetails!);
            await this
                .userRepository
                .updateRegistartionStep(this.userRepository.useDetails!.id, 9);
            this.userRepository.updateRegistrationStep(9);
          }
          yield OnUpdate();
        } else {
          yield OnError(result.message);
        }
      }
    }
    if (event is AddImage) {
      if (this
              .localImagePaths
              .where((element) => element != "addImage")
              .length >=
          10) {
        yield OnError('You can select only up to 10 Images.');
        return;
      }
      var result = await this.userRepository.uploadImage(event.images);
      if (result != null) {
        this.localImagePaths.insert((this.localImagePaths.length - 1), result);
        yield BioInitialState();
      } else {
        yield OnError('Could not upload image');
      }
    }
    if (event is ChangeProfilePic) {
      this.profileImage = event.image;
      yield BioInitialState();
    }
    if (event is RemoveImage) {
      if (this.profileImage == this.localImagePaths[event.pos]) {
        yield OnError("You can't remove an image that is selected as profile image.");
      }
      else {
        this.localImagePaths.removeAt(event.pos);
        yield BioInitialState();
      }
    }
    if (event is FetchMyImage) {
      var response = await this.userRepository.getOtheruserDetails(
          userRepository.useDetails!.id,
          ProfileActivationStatus
              .values[userRepository.useDetails!.activationStatus]);

      if (response.status == AppConstants.SUCCESS) {
        this.profileData = response.profileDetails;
        this.aboutMeMsg = response.profileDetails.aboutMe;
        yield OnGotProfileandImages(this.profileData!);
      } else {
        yield OnError(response.message);
      }
    }
  }
}
