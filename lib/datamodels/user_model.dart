import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class SigninResponse {
  late String message, status;
  UserDetails? userDetails;

  SigninResponse.fromJson(json, {OtpType? otpType}) {
    this.status = json["type"];
    this.message = json["message"];
    if (this.status == AppConstants.SUCCESS) {
      if (otpType != OtpType.Registration)
        this.userDetails = UserDetails.fromJson(json["data"]["userBasic"]);
    }
  }

  SigninResponse.fromError(String error) {
    this.message = error;
    this.status = AppConstants.FAILURE;
  }
}

class UserDetails {
  late String id, email, mobile, dialCode;
  late bool isActive;
  late int gender, registrationStep, lifecycleStatus, activationStatus;
  late Relationship relationship;
  late String password;
  late String dateOfBirth;
  late double height;
  late MaritalStatus maritalStatus;
  late CountryModel countryModel;
  late SimpleMasterData religion;
  late AbilityStatus abilityStatus;

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

class PreSignUrlResponse {
  late String status, message;
  String? imageUrl;

  PreSignUrlResponse.fromJson(data) {
    this.status = data["type"];
    this.message = data["message"];
    if (status == AppConstants.SUCCESS) {
      this.imageUrl = data["data"];
    }
  }

  PreSignUrlResponse.fromError(String message) {
    this.status = AppConstants.FAILURE;
    this.message = message;
  }
}
