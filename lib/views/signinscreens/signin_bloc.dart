import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/signinscreens/signin_event.dart';
import 'package:makemymarry/views/signinscreens/signin_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';

import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

class SignInBloc extends Bloc<SignInEvent, SigninState> {
  final UserRepository userRepository;

  String email = '', password = '';

  SignInBloc(this.userRepository) : super(SigninInitialState());

  @override
  Stream<SigninState> mapEventToState(SignInEvent event) async* {
    yield OnLoading();

    if (event is ValidateAndSignin) {
      yield OnLoading();
      this.email = event.email;
      this.password = event.password;
      if (!RegExp(AppConstants.EMAILREGEXP).hasMatch(this.email)) {
        yield OnError("Enter Valid Email");
      } else if (!RegExp(AppConstants.PASSWORDREGEXP).hasMatch(this.password)) {
        yield OnError("Password must be alphanumeric and of size 8 or more.");
      } else {
        var result = await this.userRepository.login(this.email, this.password);
        //or  var result=await this.userRepository.apiClient.signinUser(email, password);
        if (result.status == AppConstants.FAILURE) {
          print('result.status=${result.status}');
          yield OnValidationFail('Entered email and password is incorrect.');
        } else if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails = result.userDetails;
          var res = await this.userRepository.getOtheruserDetails(
              this.userRepository.useDetails!.id,
              ProfileActivationStatus
                  .values[userRepository.useDetails!.activationStatus]);
          if(res.status == AppConstants.SUCCESS){
            this.userRepository.useDetails?.dateOfBirth = res.profileDetails.dateOfBirth;
            this.userRepository.useDetails?.name = res.profileDetails.name;
            this.userRepository.useDetails?.height = res.profileDetails.height;
            this.userRepository.useDetails?.gender = res.profileDetails.gender.index;
            this.userRepository.useDetails?.maritalStatus = res.profileDetails.maritalStatus;
            this.userRepository.useDetails?.abilityStatus = res.profileDetails.abilityStatus;
            this.userRepository.useDetails?.activationStatus = res.profileDetails.activationStatus.index;
            this.userRepository.useDetails?.imageUrl = res.profileDetails.images.isNotNullEmpty ? res.profileDetails.images.first : "";
          }
          await this
              .userRepository
              .storageService
              .saveUserDetails(this.userRepository.useDetails!);
          yield OnSignIn(this.userRepository.useDetails!);
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
