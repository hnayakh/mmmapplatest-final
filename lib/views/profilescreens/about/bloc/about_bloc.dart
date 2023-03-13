import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/app_helper.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profilescreens/about/bloc/about_event.dart';
import 'package:string_validator/string_validator.dart';

import 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  late final UserRepository userRepository;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController editNameController = TextEditingController();
  AboutBloc(this.userRepository)
      : super(
          AboutIdleState(
            maritalStatus: MaritalStatus.NeverMarried,
            abilityStatus: AbilityStatus.Normal,
            childrenStatus: ChildrenStatus.No,
            noOfChildren: NoOfChildren.One,
            heightStatus: 48,
            dateOfBirth: null,
            name: null,
          ),
        );

  ProfileDetails? profileDetails;
  String?basicUserId;

  @override
  Stream<AboutState> mapEventToState(AboutEvent event) async* {
    if (event is OnAboutDataLoad) {
      yield OnLoading();
      var result = await this.userRepository.getOtheruserDetails(
          event.basicUserId, ProfileActivationStatus.Verified);

      if (result.status == AppConstants.SUCCESS) {
        this.profileDetails = result.profileDetails;
        editNameController.text = profileDetails?.name ?? "";
        yield AboutIdleState(
            maritalStatus: profileDetails?.maritalStatus,
            abilityStatus: profileDetails?.abilityStatus,
            childrenStatus: profileDetails?.childrenStatus,
            noOfChildren: profileDetails?.noOfChildren,
            heightStatus: (profileDetails?.height ?? 48).toInt(),
            dateOfBirth: DateTime.parse(profileDetails!.dateOfBirth),
            name: profileDetails?.name);
      } else {
        yield OnError(result.message);
      }
    }
    if (event is OnNameChanged) {
      yield (state as AboutIdleState).copyWith(name: event.name);
    }
    if (event is OnMaritalStatusSelected) {
      if (event.ms == MaritalStatus.NeverMarried) {
        yield (state as AboutIdleState).copyWith(
            maritalStatus: event.ms, childrenStatus: ChildrenStatus.No);
      } else {
        yield (state as AboutIdleState).copyWith(maritalStatus: event.ms);
      }
    }
    if (event is OnChangeNoOfChildren) {
      yield (state as AboutIdleState)
          .copyWith(noOfChildren: event.noOfChildren);
    }
    if (event is OnHeightStatusSelected) {
      yield (state as AboutIdleState).copyWith(heightStatus: event.height);
    }
    if (event is OnChildrenSelected) {
      var newState = (state as AboutIdleState)
          .copyWith(childrenStatus: event.childrenStatus);
      // yield OnLoading();
      yield newState;
    }
    if (event is OnDisabilitySelected) {
      yield (state as AboutIdleState)
          .copyWith(abilityStatus: event.abilityStatus);
    }
    if (event is OnDOBSelected) {
      yield (state as AboutIdleState).copyWith(dateOfBirth: event.dob);
    }
    if (event is OnAboutDone) {
      var state = this.state;
      if ((state as AboutIdleState).name == '' &&
          (state as AboutIdleState).maritalStatus == null &&
          (state as AboutIdleState).heightStatus == null &&
          (state as AboutIdleState).childrenStatus == null &&
          (state as AboutIdleState).dateOfBirth == null &&
          (state as AboutIdleState).abilityStatus == null) {
        yield OnError('Please enter all mandatory details');
      }
      if ((state as AboutIdleState).name == '' || !isAlpha((state as AboutIdleState).name ?? "")) {
        yield OnError('Enter valid username.');
      } else if ((state as AboutIdleState).maritalStatus == null) {
        yield OnError('Select marital status.');
      } else if ((state as AboutIdleState).heightStatus == null) {
        yield OnError('Select your height.');
      } else if ((state as AboutIdleState).dateOfBirth == null) {
        yield OnError('Select date of birth.');
      } else if ((state as AboutIdleState).childrenStatus == null) {
        yield OnError('Specify if you have children.');
      } else if ((state as AboutIdleState).abilityStatus == null) {
        yield OnError('Specify disability if any.');
      } else {
        var result = await this.userRepository.about(
            (state as AboutIdleState).noOfChildren,
            (state as AboutIdleState).maritalStatus,
            (state as AboutIdleState).abilityStatus,
            (state as AboutIdleState).childrenStatus,
            (state as AboutIdleState).heightStatus,
            AppHelper.serverFormatDate((state as AboutIdleState).dateOfBirth!),
            (state as AboutIdleState).name);

        if (result.status == AppConstants.SUCCESS) {
          this.userRepository.useDetails!.dateOfBirth =
              AppHelper.serverFormatDate(
                  (state as AboutIdleState).dateOfBirth!);
          this.userRepository.useDetails!.maritalStatus =
              (state as AboutIdleState).maritalStatus!;
          this.userRepository.useDetails!.height =
              (state as AboutIdleState).heightStatus!.toDouble();
          this.userRepository.useDetails!.abilityStatus =
              (state as AboutIdleState).abilityStatus!;
          print(this.userRepository.useDetails!.height.toString() + "========================== height");
          await this
              .userRepository
              .storageService
              .saveUserDetails(this.userRepository.useDetails!);
          if (!event.isAnUpdate) {
            await this
                .userRepository
                .updateRegistartionStep(this.userRepository.useDetails!.id, 3);
            this.userRepository.updateRegistrationStep(3);
          }
          yield event.isAnUpdate
              ? OnNavigationToMyProfiles()
              : OnNavigationToHabits();
        } else {
          yield OnError(result.message);
        }
      }
      yield state;
    }
  }
}
