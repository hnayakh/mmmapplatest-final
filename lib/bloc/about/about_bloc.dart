import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/bloc/about/about_event.dart';
import 'package:makemymarry/bloc/about/about_state.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  late final UserRepository userRepository;

  AboutBloc(this.userRepository) : super(AboutInitialState());
  MaritalStatus? maritalStatus;
  AbilityStatus? abilityStatus;
  ChildrenStatus? childrenStatus;
  NoOfChildren? noOfChildren;
  int? heightStatus;
  DateTime? dateOfBirth;
  String? name;
  ProfileDetails? profileDetails;
  @override
  Stream<AboutState> mapEventToState(AboutEvent event) async* {
    yield OnLoading();
    if (event is onAboutDataLoad) {
      var result = await this.userRepository.getOtheruserDetails(
          event.basicUserId, ProfileActivationStatus.Verified);

      if (result.status == AppConstants.SUCCESS) {
        this.profileDetails = result.profileDetails;
        yield ProfileDetailsState(result.profileDetails);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is OnMaritalStatusSelected) {
      this.maritalStatus = event.ms;
      if (event.ms == MaritalStatus.NeverMarried) {
        this.childrenStatus = ChildrenStatus.No;
      }
      yield AboutInitialState();
    }
    if (event is OnChangeNoOfChildren) {
      this.noOfChildren = event.noOfChildren;
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
      this.dateOfBirth = event.dob;
      yield AboutInitialState();
    }
    if (event is OnAboutDone) {
      this.name = event.name;
      if (this.name == '' &&
          this.maritalStatus == null &&
          this.heightStatus == null &&
          this.childrenStatus == null &&
          this.dateOfBirth == null &&
          this.abilityStatus == null) {
        yield OnError('Please enter all mandatory details');
      }
      if (this.name == '') {
        yield OnError('Enter valid username.');
      } else if (this.maritalStatus == null) {
        yield OnError('Select marital status.');
      } else if (this.heightStatus == null) {
        yield OnError('Select your height.');
      } else if (this.dateOfBirth == null) {
        yield OnError('Select date of birth.');
      } else if (this.childrenStatus == null) {
        yield OnError('Specify if you have children.');
      } else if (this.abilityStatus == null) {
        yield OnError('Specify disability if any.');
      } else {
        var result = await this.userRepository.about(
            this.noOfChildren,
            this.maritalStatus,
            this.abilityStatus,
            this.childrenStatus,
            this.heightStatus,
            AppHelper.serverFormatDate(this.dateOfBirth!),
            this.name);

        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails!.dateOfBirth =
              AppHelper.serverFormatDate(this.dateOfBirth!);

          this.userRepository.useDetails!.maritalStatus = this.maritalStatus!;
          this.userRepository.useDetails!.height =
              double.parse(AppHelper.getHeights()[this.heightStatus!]);
          this.userRepository.useDetails!.abilityStatus = this.abilityStatus!;

          // await this.userRepository.saveUserDetails();
          await this
              .userRepository
              .storageService
              .saveUserDetails(this.userRepository.useDetails!);
          this.userRepository.updateRegistrationStep(3);

          yield OnNavigationToHabits();
        } else {
          yield OnError(result.message);
        }
      }
    }
  }
}
