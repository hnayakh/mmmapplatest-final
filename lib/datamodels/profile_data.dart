import 'package:makemymarry/repo/user_repo.dart';
import 'package:makemymarry/utils/app_constants.dart';

class ProfileDataResponse {
  late String message, status;
  late List<ProfileDetails> listProfileDetails;
  late String id;
  ProfileDataResponse.fromJson(json, userId) {
    this.status = json["type"];
    this.message = json["message"];
    this.id = userId;

    if (this.status == AppConstants.SUCCESS) {
      this.listProfileDetails = [];
      for (var item in json["data"]) {
        if (item["registrationStep"] == 9 && item["id"] != userId) {
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
  String name = 'data not available';
  late String height;
  late String dateOfBirth;
  //int numberOfChildren = -1;
  int gothra = -1;
  int isManglik = -1;
  late int maritalStatus, gender;
  late int childrenStatus;
  late int abilityStatus;
  late String religion,
      email,
      countryCode,
      phoneNumber,
      id,
      cast,
      motherTongue,
      employedIn,
      occupation,
      annualIncome,
      highestEducation,
      imageURL,
      thumbnailURL;

  late int careerCountry,
      careerState,
      careerCity,
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
      marriedNumberOfSisters,
      eatingHabit,
      relationship,
      smokingHabit,
      drinkingHabit,
      country,
      state,
      city;

  //when childrenStatus==0,cast=="hindu"
  // var gothra, isManglik;

//receives single item from list of json['data']
  ProfileDetails.fromJson(json) {
    //this.aboutMe = json["aboutMe"];

    this.id = json["id"];
    this.email = json["email"];
    this.gender = json["gender"];
    this.countryCode = json["countryCode"];
    this.phoneNumber = json["phoneNumber"];
    this.relationship = json["relationship"];
    // this.eatingHabit = json["eatingHabit"];
    //  this.smokingHabit = json["smokingHabit"];
    // this.drinkingHabit = json["drinkingHabit"];
    // this.religion = json["religion"];
    /// this.cast = json["cast"];
    //  if (json["gothra"] != null) {
    //    this.gothra = json["gothra"];
    //  }
//
    //  if (json["isManglik"] != null) {
    //   this.isManglik = json["isManglik"];
    //  }

    //  this.motherTongue = json["motherTongue"];

    // this.employedIn = json["employedIn"];
    // this.occupation = json["occupation"];
    // this.annualIncome = json["annualIncome"];
    // this.highestEducation = json["highestEducation"];
    // this.careerCountry = json["careerCountry"];
    //this.careerState = json["careerState"];
    // this.careerCity = json["careerCity"];
    // this.familyStatus = json["familyStatus"];
    // this.familyValues = json["familyValues"];
    //  this.familyType = json["familyType"];
    //  this.familyCountry = json["familyCountry"];
    //  this.familyState = json["familyState"];
    //  this.familyCity = json["familyCity"];
    //  this.fatherOccupation = json["fatherOccupation"];
    // this.motherOccupation = json["motherOccupation"];
    // this.numberOfBrothers = json["numberOfBrothers"];
    //  this.marriedNumberOfBrothers = json["marriedNumberOfBrothers"];
    //  this.numberOfSisters = json["numberOfSisters"];
    //  this.marriedNumberOfSisters = json["marriedNumberOfSisters"];

    //  this.imageURL = json["imageURL"];
    //  this.thumbnailURL = json["thumbnailURL"];
    //  this.name = json["name"];
    //  this.dateOfBirth = json["dateOfBirth"];
    //   this.height = json["height"];
    // this.maritalStatus = json["maritalStatus"];
    //  this.childrenStatus = json["childrenStatus"];
    // this.abilityStatus = json["abilityStatus"];

    // this.numberOfChildren = json["numberOfChildren"];
  }
}
