import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/bloc/about/about_event.dart';
import 'package:makemymarry/bloc/about/about_state.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  late final UserRepository userRepository;

  AboutBloc(this.userRepository) : super(AboutInitialState());
  MaritalStatus? maritalStatus;
  AbilityStatus? abilityStatus;
  ChildrenStatus? childrenStatus;
  int? heightStatus;
  String dob = 'dd MMM yyyy';
  String? name;

  @override
  Stream<AboutState> mapEventToState(AboutEvent event) async* {
    yield OnLoading();
    if (event is OnMaritalStatusSelected) {
      this.maritalStatus = event.ms;
      yield AboutInitialState();
    }
    if (event is OnHeightStatusSelected) {
      this.heightStatus = event.height;
      yield AboutInitialState();
    }
    if (event is OnChildrenSelected) {
      this.childrenStatus = event.childrenStatus;
      yield AboutInitialState();
    }
    if (event is OnDisabilitySelected) {
      this.abilityStatus = event.abilityStatus;
      yield AboutInitialState();
    }
    if (event is OnDOBSelected) {
      this.dob = event.dob;
      yield AboutInitialState();
    }
    if (event is OnAboutDone) {
      this.name = event.name;
      if (this.name == '') {
        yield OnError('Enter valid username.');
      } else if (this.maritalStatus == null) {
        yield OnError('Select marital status.');
      } else if (this.heightStatus == null) {
        yield OnError('Select your height.');
      } else if (this.dob == 'dd MMM yyyy') {
        yield OnError('Select date of birth.');
      } else if (this.childrenStatus == null) {
        yield OnError('Specify if you have children.');
      } else if (this.abilityStatus == null) {
        yield OnError('Specify disability if any.');
      } else {
        var result = await this.userRepository.about(
            this.maritalStatus,
            this.abilityStatus,
            this.childrenStatus,
            this.heightStatus,
            this.dob,
            this.name);

        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails = result.userDetails;
          // await this.userRepository.saveUserDetails();
          yield OnNavigationToHabits();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
