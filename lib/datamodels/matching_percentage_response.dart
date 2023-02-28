import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/preference_helper.dart';

import 'master_data.dart';

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
  late String userImage;

  MatchingPercentageResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];
    this.matchingFields = json["data"]["matchingFields"];
    this.differentFields = json["data"]["differentFields"];
    this.percent = int.parse(json["data"]["match_percentage"]);
    this.userImage = (json["data"]["userImage"]['imageURL']);
  }

  MatchingPercentageResponse.fromError(String message) {
    this.status = AppConstants.FAILURE;
    this.message = message;
  }
}




