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

    if (event is UpdateBio) {
      if (event.bio.length == 0) {
        yield OnError("Enter Bio");
      } else if (this.localImagePaths.length == 0) {
        yield OnError("Add Images");
      } else {
        var result = await this
            .userRepository
            .updateBio(event.bio, this.localImagePaths);
        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails!.registrationStep = 9;
          //await this.userRepository.saveUserDetails();
          await this
              .userRepository
              .storageService
              .saveUserDetails(this.userRepository.useDetails!);
          this.userRepository.updateRegistrationStep(9);
          print('in bio');
          print('dobinbiobloc=${this.userRepository.useDetails!.dateOfBirth}');
          print(this.userRepository.useDetails!.registrationStep);
          yield OnUpdate();
        } else {
          yield OnError(result.message);
        }
      }
    }
    if (event is AddImage) {
      var result = await this.userRepository.uploadImage(event.images);
      if (result != null) {
        this.localImagePaths.add(result);
        yield BioInitialState();
      } else {
        yield OnError("Could Not Upload File.");
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
  }
}
