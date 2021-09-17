import 'package:makemymarry/utils/app_constants.dart';

class ProfileDataResponse {
  late String message, status;
  late List<ProfileDetails> listProfileDetails;

  ProfileDataResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];
    if (this.status == AppConstants.SUCCESS) {
      this.listProfileDetails = [];
      for (var item in json["data"]) {
        if (item["userBios"].length != 0 && item["userAbouts"].length != 0) {
          listProfileDetails.add(ProfileDetails.fromJson(item));
        }
      }

      //data is a list of  user information maps.
    }
  }

  ProfileDataResponse.fromError(String error) {
    this.message = error;
    this.status = AppConstants.FAILURE;
  }
}

class ProfileDetails {
  late String aboutMe;
  late String name;
  late String height;
  late String dateOfBirth;
  int numberOfChildren = -1;
  late int maritalStatus;
  late int childrenStatus;
  late int abilityStatus;
  late String religion,
      cast,
      motherTongue,
      employedIn,
      occupation,
      annualIncome,
      highestEducation,
      imageUrl;

  late int eatingHabit,
      smokingHabit,
      drinkingHabit,
      country,
      state,
      city,
      familyStatus,
      familyValues,
      familyType,
      familyCountry,
      familyState,
      familyCity,
      fatherOccupation,
      motherOccupation,
      numberOfBrothers,
      marriedNumberOfBrothers,
      numberOfSisters,
      marriedNumberOfSisters;

  //when childrenStatus==0,cast=="hindu"
  var gothra, isManglik;

//receives single item from list of json['data']
  ProfileDetails.fromJson(json) {
    for (var item in json["userBios"]) {
      if (item["profileUpdationStatus"] == 1) {
        this.aboutMe = item["aboutMe"];
      }
    }

    for (var item in json["userAbouts"]) {
      if (item["profileUpdationStatus"] == 1) {
        this.name = item["name"];
        this.dateOfBirth = item["dateOfBirth"];
        this.height = item["height"];
        this.maritalStatus = item["maritalStatus"];
        this.childrenStatus = item["childrenStatus"];
        this.abilityStatus = item["abilityStatus"];
        if (item["numberOfChildren"] != null) {
          this.numberOfChildren = item["numberOfChildren"];
        }
      }
    }
  }
}
