import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/preference_helper.dart';

class ProfilePercent {
  late int percent;

  ProfilePercent.fromJson(json) {
    this.percent = json["data"];
  }
}

class MatchingPercentageResponse {
  late String status, message;
  late int percent;
  late List matchingFields;
  late List differentFields;

  MatchingPercentageResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];
    this.matchingFields = json["matchingFields"];
    this.differentFields = json["differentFields"];
    this.percent = json["data"];
  }

  MatchingPercentageResponse.fromError(String message) {
    this.status = AppConstants.FAILURE;
    this.message = message;
  }
}
