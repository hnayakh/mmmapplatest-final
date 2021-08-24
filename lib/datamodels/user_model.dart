import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class UserDetails {
  late String id, email, mobile, dialCode;
  late bool isActive;
  late int gender, registrationStep, lifecycleStatus, activationStatus;
  late Relationship relationship;

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
    this.relationship = Relationship.values[json["relationship"]];
  }

  UserDetails.fromStorage(
      this.id,
      this.mobile,
      this.dialCode,
      this.email,
      this.gender,
      this.isActive,
      this.lifecycleStatus,
      this.activationStatus,
      this.registrationStep);
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

class SigninResponse {
  late String message, status;
  UserDetails? userDetails;

  SigninResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];
    if (this.status == AppConstants.SUCCESS) {
      this.userDetails = UserDetails.fromJson(json["data"]["userBasic"]);
    }
  }

  SigninResponse.fromError(String error) {
    this.message = error;
    this.status = AppConstants.FAILURE;
  }
}

class SendOtpResponse {
  late String message, status;
  UserDetails? userDetails;

  SendOtpResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];
  }

  SendOtpResponse.fromError(String error) {
    this.message = error;
    this.status = AppConstants.FAILURE;
  }
}
