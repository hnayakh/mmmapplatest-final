import 'dart:async';

import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/matching_percentage/matching_percentage_event.dart';
import 'package:rxdart/rxdart.dart';

// STEP1:  Stream setup
class StreamSocket {
  final _socketResponse = BehaviorSubject<MatchingProfile>();

  void Function(MatchingProfile) get addResponse => _socketResponse.add;

  Stream<MatchingProfile> get getResponse => _socketResponse.stream;
  MatchingProfile get currentData => _socketResponse.value;

  void dispose() {
    _socketResponse.close();
  }
}
