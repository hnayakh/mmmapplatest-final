import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/repo/user_repo.dart';

import 'meet_form_state.dart';

class MeetFormBloc extends Cubit<MeetFormState> {
  MeetFormBloc({required this.userRepository, this.profileDetails, this.meet})
      : super(MeetFormState.initial(meet: meet)) {
    if (meet == null) {
      showMeetTypeWidget();
    }
  }

  final UserRepository userRepository;
  final ProfileDetails? profileDetails;
  final Activeconnection? meet;

  showMeetTypeWidget() async {
    await Future.delayed(Duration(seconds: 1));
    emit(state.copyWith(meetViewState: EMeetViewState.typeSheet));
  }

  submitMeetType(MeetType meetType) {
    if (meetType == MeetType.virtual) {
      emit(state.copyWith(
          meetViewState: EMeetViewState.selectDatePage, meetType: meetType));
    } else {
      emit(state.copyWith(
          meetViewState: EMeetViewState.selectLocationPage,
          meetType: meetType));
    }
  }

  submitMeetLocation(LatLng? latlng, String? address) {
    if (latlng == null) {
      emit(state.copyWith(
          formState: CustomFormState.error,
          message: "Please select a valid location."));
    } else {
      emit(state.copyWith(
          meetViewState: EMeetViewState.selectDatePage,
          address: address ?? '',
          location: latlng));
    }
  }

  submitMeetDate(DateTime? meetDate) {
    if (meetDate == null) {
      emit(state.copyWith(
          formState: CustomFormState.error,
          message: "Please select a valid date."));
    } else {
      emit(state.copyWith(
          meetViewState: EMeetViewState.selectTimePage,
          meetDateTime: meetDate));
    }
  }

  submitMeetTime(DateTime? meetTime) {
    if (meetTime == null) {
      emit(state.copyWith(
          formState: CustomFormState.error,
          message: "Please select a valid time.",
          meetViewState: EMeetViewState.meetCreated));
    } else {
      DateTime meetDateTime = DateTime(
        state.meetDateTime!.year,
        state.meetDateTime!.month,
        state.meetDateTime!.day,
        meetTime.hour,
        meetTime.minute,
      );
      emit(state.copyWith(
          meetDateTime: meetDateTime,
          message: null,
          meetViewState: EMeetViewState.meetCreated));

    }
  }

  createMeetRequest() async {
    try {
      emit(state.copyWith(formState: CustomFormState.uploading));
      var res = await userRepository.createMeetRequest(
        scheduleTime: state.meetDateTime!,
        meetType: state.meetType!,
        otherUserId: profileDetails!.id,
        latLng:
            state.meetType == MeetType.virtual ? LatLng(0, 0) : state.location!,
        location: state.meetType == MeetType.virtual ? "" : state.address!,
      );
      if (res.status == "SUCCESS") {
        emit(state.copyWith(
            formState: CustomFormState.success,
            message: "Meet Request added successfully",
            meetViewState: EMeetViewState.meetCreated));
      } else {
        emit(state.copyWith(
            formState: CustomFormState.error,
            message: "Sorry, Please try again later",
            meetViewState: EMeetViewState.meetCreated));
      }
    } catch (e) {
      emit(state.copyWith(
          formState: CustomFormState.error,
          message: e.toString(),
          meetViewState: EMeetViewState.meetCreated));
    }
  }

  updateMeetRequest() async {
    try {
      emit(state.copyWith(formState: CustomFormState.uploading));
      var res = await userRepository.updateMeetRequest(
        scheduleTime: state.meetDateTime ?? state.meet!.scheduleTime,
        meet: state.meet!,
        latLng:
            state.location ?? LatLng(state.meet!.lat, state.meet!.long),
        location: state.address ?? state.meet!.address,
      );
      if (res.status == "SUCCESS") {
        emit(state.copyWith(
            formState: CustomFormState.success,
            message: "Meet Request added successfully"));
      } else {
        emit(state.copyWith(
            formState: CustomFormState.error,
            message: "Sorry, Please try again later"));
      }
    } catch (e) {
      emit(state.copyWith(
          formState: CustomFormState.error, message: e.toString()));
    }
  }
}

enum MeetType {
  virtual,
  realTime,
}
