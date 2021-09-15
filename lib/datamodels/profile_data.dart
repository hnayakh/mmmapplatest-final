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
        listProfileDetails.add(ProfileDetails.fromJson(item));
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
  String aboutMe = 'data not available';
  String name = 'data not available';
  String height = 'data not available';
  String dateOfBirth = 'data not available';
  int numberOfChildren = -1;
  int maritalStatus = -1;
  int childrenStatus = -1;
  int abilityStatus = -1;
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
    if (json["userBios"] != []) {
      for (var item in json["userBios"]) {
        if (item["profileUpdationStatus"] == 1) {
          this.aboutMe = item["aboutMe"];
        }
      }
    }
    ////else {
    // this.aboutMe = 'not available';
    //   }

    if (json["userAbouts"] != []) {
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

          //else {
          //   this.numberOfChildren = -1;
          //  }
        }
      }
    }
    // else {
    //  this.name = 'not available';
    //  this.dateOfBirth = 'not available';
    //  this.height = 'not available';
    //  this.maritalStatus = -1;
    //  this.childrenStatus = -1;
    //  this.abilityStatus = -1;
    //this.numberOfChildren = 0;
    // }
  }
}
