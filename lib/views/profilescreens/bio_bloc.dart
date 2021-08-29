import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

import 'bio_event.dart';
import 'bio_state.dart';

class BioBloc extends Bloc<BioEvent, BioState> {
  final UserRepository userRepository;

  BioBloc(this.userRepository) : super(BioInitialState());
  String aboutMe = '';
  String imageUrl1 = '';
  String imageUrl2 = '';
  String imageUrl3 = '';
  String imageUrl4 = '';

  @override
  Stream<BioState> mapEventToState(BioEvent event) async* {
    yield OnLoading();

    if (event is UpdateBioEvent) {
      this.aboutMe = event.aboutMe;
      this.imageUrl1 = event.imageUrl1;
      this.imageUrl2 = event.imageUrl2;
      this.imageUrl3 = event.imageUrl3;
      this.imageUrl4 = event.imageUrl4;
      if (this.aboutMe == '') {
        yield OnError('please fill the about me section.');
      } else if (this.imageUrl1 == '' &&
          this.imageUrl2 == '' &&
          this.imageUrl3 == '' &&
          this.imageUrl4 == '') {
        yield OnError('Please upload atleast one photo.');
      } else {
        var result = await this.userRepository.updateBio(this.aboutMe,
            this.imageUrl1, this.imageUrl2, this.imageUrl3, this.imageUrl4);

        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails = result.userDetails;
          // await this.userRepository.saveUserDetails();
          yield OnProfileSetupCompletion();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
