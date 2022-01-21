import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class SigninResponse {
  late String message, status;
  UserDetails? userDetails;

  SigninResponse.fromJson(json, {OtpType? otpType}) {
    this.status = json["type"];
    this.message = json["message"];
    print(this.status);
    if (this.status == AppConstants.SUCCESS) {
      if (otpType != OtpType.Registration)
        this.userDetails = UserDetails.fromJson(json["data"]["userBasic"]);
      if ((json["data"] as Map).containsKey("requiredLoginDetails")) {
        var extraData = json["data"]["requiredLoginDetails"];
        if (extraData.length > 0) {
          print('extradata=$extraData');
          if (extraData[0]["motherTongue"] != null) {
            userDetails!.motherTongue = SimpleMasterData()
              ..id = extraData[0]["motherTongue"]
              ..title = extraData[0]["motherTongue"];
          }
          if (extraData[0]["dateOfBirth"] != null) {
            userDetails!.dateOfBirth = extraData[0]["dateOfBirth"];
          }
          if (extraData[0]["height"] != null) {
            userDetails!.height = double.parse(extraData[0]["height"]);
          }
          if (extraData[0]["maritalStatus"] != null) {
            userDetails!.maritalStatus =
                MaritalStatus.values[extraData[0]["maritalStatus"]];
          }

          if (extraData[0]["careerCountryId"] != null) {
            userDetails!.countryModel = CountryModel()
              ..id = extraData[0]["careerCountryId"]
              ..name = extraData[0]["careerCountry"]
              ..shortName = extraData[0]["careerCountry"];
          }
          if (extraData[0]["religion"] != null) {
            userDetails!.religion = SimpleMasterData()
              ..id = extraData[0]["religion"]
              ..title = extraData[0]["religion"];
          }
          if (extraData[0]["abilityStatus"] != null) {
            userDetails!.abilityStatus =
                AbilityStatus.values[extraData[0]["abilityStatus"]];
          }
        }
      }
    }
  }

  SigninResponse.fromError(String error) {
    print('we are in json error');
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

  late SimpleMasterData motherTongue;

  UserDetails.fromJson(json) {
    this.id = json["id"];
    this.email = json["email"];
    this.mobile = json["phoneNumber"];
    this.dialCode = json["countryCode"];
    this.isActive = json["isActive"];
    this.gender = json["gender"];
    this.registrationStep = json["registrationStep"];
    print('usermodel_regstpe=${this.registrationStep}');
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
    this.registrationStep,
    this.dateOfBirth,
    this.relationship,
    this.height,
    this.maritalStatus,
    this.abilityStatus,
    this.countryModel,
    this.religion,
    this.motherTongue,
  );
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

class SimpleResponse {
  late String status, message;

  SimpleResponse.fromJson(json) {
    print(json["message"]);
    this.status = json["type"];
    this.message = json["message"];
  }

  SimpleResponse.fromError(String error) {
    this.status = AppConstants.FAILURE;
    this.message = error;
  }
}
