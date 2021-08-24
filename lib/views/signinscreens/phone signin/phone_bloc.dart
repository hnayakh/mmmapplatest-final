import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

import 'phone_event.dart';
import 'phone_state.dart';

class PhoneSigninBloc extends Bloc<PhoneSigninEvent, PhoneSigninState> {
  late final UserRepository userRepository;

  PhoneSigninBloc(this.userRepository) : super(PhoneSigninInitialState());

  late String dialCode;
  late String mobile;

  @override
  Stream<PhoneSigninState> mapEventToState(PhoneSigninEvent event) async* {
    yield OnLoading();
    if (event is OnNavigateToMobileVerification) {
      this.dialCode = event.dialCode;
      this.mobile = event.mobile;

      var result = await this.userRepository.sendOtp(
            this.dialCode,
            this.mobile,
          );

      if (result.status == AppConstants.SUCCESS) {
        yield MoveToMobileVerification();
      } else {
        yield OnError(result.message);
      }
    }
  }
}
