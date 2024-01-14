import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/utils/buttons.dart';
import 'package:makemymarry/utils/colors.dart';
import 'package:makemymarry/utils/helper.dart';
import 'package:makemymarry/utils/text_styles.dart';
import 'package:makemymarry/views/meet/bloc/meet_form_bloc.dart';
import 'package:makemymarry/views/meet/bloc/meet_form_state.dart';
import 'package:makemymarry/views/meet/views/meet_timing/schedule_meeting_date.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

import '../../../locator.dart';
import '../../../repo/user_repo.dart';
import '../../../utils/alert.dart';

class MeetLocationView extends StatefulWidget {
  MeetLocationView({this.connection, this.profileDetails, key})
      : super(key: key);

  static getRoute({
    Activeconnection? connection,
    ProfileDetails? profileDetails,
  }) =>
      MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (_) => MeetFormBloc(
                  userRepository: getIt<UserRepository>(),
                  profileDetails: profileDetails,
                meet: connection,
              ),
              child: MeetLocationView(
                  connection: connection, profileDetails: profileDetails)));

  final Activeconnection? connection;
  final ProfileDetails? profileDetails;

  @override
  State<MeetLocationView> createState() => _MeetLocationViewState();
}

class _MeetLocationViewState extends State<MeetLocationView> {
  @override
  void initState() {
    _controller = Completer<GoogleMapController>();
    if (widget.connection != null) {
      updateLatLong(LatLng(widget.connection!.lat, widget.connection!.long));
      currentAddress = widget.connection!.address;
      _controller.future.then((value) {
        value.moveCamera(CameraUpdate.newLatLngZoom(
            LatLng(widget.connection!.lat, widget.connection!.long,), 14));
      });
    }else {
      geCurrentLocation().then((value) {
        updateLatLong(value);
      }).catchError((err) {});
    }
    super.initState();
  }

  final CameraPosition cameraPosition =
      CameraPosition(target: LatLng(0, 0), zoom: 14);
  late Completer<GoogleMapController> _controller;
  LatLng selectedLatLong = LatLng(0, 0);
  bool loading = false;
  String currentAddress = '';
  GoogleMapController? mapController;

  updateLatLong(LatLng latLng) {
    setState(() {
      this.selectedLatLong = latLng;
      getAddressFromLatLng(this.selectedLatLong);
    });
  }

  Future<LatLng> geCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    var permission = await Permission.locationWhenInUse.status;
    if (permission != PermissionStatus.granted) {
      permission = await Permission.locationWhenInUse.request();
      while (permission != PermissionStatus.granted) {
        await Alert.message(
          navigatorKey.currentContext!,
          message: 'Please enable location in settings of the app',
          popsAutomatically: false,
          barrierDismissible: false,
          onPressed: () async {
            permission = await Permission.locationWhenInUse.status;
            if (permission == PermissionStatus.granted) {
              navigatorKey.currentState?.pop();
            } else {
              await openAppSettings();
            }
          },
        );
      }
    }
    final _locationData = await Geolocator.getCurrentPosition();

    await _controller.future.then((value) {
      value.moveCamera(CameraUpdate.newLatLng(
          LatLng(_locationData.latitude, _locationData.longitude)));
    });

    return LatLng(_locationData.latitude, _locationData.longitude);
  }

  Future<void> getAddressFromLatLng(LatLng position) async {
    setState(() {
      loading = true;
    });
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placeMarks) {
      var place = placeMarks[0];
      setState(() {
        currentAddress = "${place.locality ?? ''}";
        loading = false;
      });
    }).catchError((e) {
      loading = false;
      currentAddress = "Sorry, Not able to find this location.";
      debugPrint(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MmmButtons.appBarCurved("Select Location"),
        body: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: cameraPosition,
                onTap: (latLong) {
                  updateLatLong(latLong);
                },
                onCameraMove: (position) {
                  // updateLatLong(position.target);
                },
                onMapCreated: (GoogleMapController mapController) {
                  _controller.complete(mapController);
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('selectedPosition'),
                    draggable: true,
                    position: selectedLatLong,
                    onDragEnd: (latLong) {
                      updateLatLong(latLong);
                    },
                  ),
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  height: 160,
                  width: context.width,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      loading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: kPrimary,
                              ),
                            )
                          : Text(
                              currentAddress,
                              textAlign: TextAlign.start,
                              style: MmmTextStyles.bodyRegular()
                                  .copyWith(color: Colors.black),
                            ),
                      SizedBox(
                        height: 12,
                      ),
                      MmmButtons.enabledRedButtonbodyMedium(
                          50, 'Confirm Location', action: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (widget.connection != null) {
                          context.read<MeetFormBloc>().submitMeetLocation(
                              selectedLatLong, currentAddress);
                          await context.read<MeetFormBloc>().updateMeetRequest();
                          if(context.read<MeetFormBloc>().state.formState == CustomFormState.success){
                            context.navigate.pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Meet Updated Successfully."
                                  ),
                              backgroundColor: kSuccess,
                            ));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Something went wrong. Please try again."),
                              backgroundColor: kError,
                            ));
                          }
                        } else {
                          context.navigate.push(BookYourDate.getRoute(
                            meetType: MeetType.realTime,
                            address: currentAddress,
                            latLng: selectedLatLong,
                            profileDetails: widget.profileDetails,
                          ));
                        }
                      })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
