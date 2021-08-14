import 'package:makemymarry/utils/app_constants.dart';

class UserDetails {
  late String id, email, mobile, dialCode;
  late bool isActive;
  late int gender, registrationStep, lifecycleStatus, activationStatus;

  UserDetails.fromJson(json) {
    this.id = json["id"];
    this.email = json["email"];
    this.mobile = json["phoneNumber"];
    this.dialCode = json["countryCode"];
    this.isActive = json["isActive"];
    this.gender = json["gender"];
    this.registrationStep = json["registrationStep"];
    this.lifecycleStatus = json["lifecycleStatus"];
    this.activationStatus = json["activationStatus"];
  }
}

class RegistrationResponse {
  late String message, status;
  UserDetails? userDetails;

  RegistrationResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];
    if (this.status == AppConstants.SUCCESS) {
      this.userDetails = UserDetails.fromJson(json["data"]);
    }
  }

  RegistrationResponse.fromError(String error) {
    this.message = error;
    this.status = AppConstants.FAILURE;
  }
}
