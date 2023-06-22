import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makemymarry/datamodels/user_model.dart';

import 'meet_form_bloc.dart';

class MeetFormState {
  final CustomFormState formState;
  final EMeetViewState meetViewState;

  final bool toUpdate;
  final String? message;
  final String? address;
  final Activeconnection? meet;
  final MeetType? meetType;
  final LatLng? location;
  final DateTime? meetDateTime;

  MeetFormState({
    required this.formState,
    required this.toUpdate,
    required this.meetViewState,
    this.message,
    this.address,
    this.meet,
    this.meetType,
    this.location,
    this.meetDateTime,
  });

  factory MeetFormState.initial(
          { Activeconnection? meet}) =>
      MeetFormState(
          formState: CustomFormState.idle,
          toUpdate: meet != null,
          meet: meet,
          meetViewState: EMeetViewState.initial);
  MeetFormState copyWith({
    CustomFormState? formState,
    bool? toUpdate,
    EMeetViewState? meetViewState,
    String? message,
    String? address,
    Activeconnection? meet,
    MeetType? meetType,
    LatLng? location,
    DateTime? meetDateTime,
  }) =>
      MeetFormState(
          meetViewState: meetViewState ?? this.meetViewState,
          formState: formState ?? this.formState,
          toUpdate: toUpdate ?? this.toUpdate,
          message: message ?? this.message,
          address: address ?? this.address,
          meet: meet ?? this.meet,
          meetType: meetType ?? this.meetType,
        location: location ?? this.location,
        meetDateTime: meetDateTime ?? this.meetDateTime
      );
}


enum CustomFormState { loading, idle, error, success, uploading }

enum EMeetViewState {
  initial,
  typeSheet,
  selectDatePage,
  selectTimePage,
  selectLocationPage,
  meetCreated,
}
