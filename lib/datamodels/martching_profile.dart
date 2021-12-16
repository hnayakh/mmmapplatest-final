import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class MatchingProfile {
  late String id,
      email,
      name,
      countryCode,
      contact,
      dateOfBirth,
      aboutMe,
      city,
      state,
      country,
      imageUrl;
  late double height;
  late int marriedNumberOfBrothers,
      noOfBrother,
      noOfSister,
      marriedNumberOfSisters;
  late Gender gender;
  late Relationship relationship;
  late MaritalStatus maritalStatus;
  late ChildrenStatus childrenStatus;
  late AbilityStatus abilityStatus;
  late EatingHabit eatingHabit;
  late SmokingHabit smokingHabit;
  late DrinkingHabit drinkingHabit;
  late Manglik manglik;
  dynamic caste;
  late FatherOccupation fatherOccupation;
  late MotherOccupation motherOccupation;
  late FamilyAfluenceLevel familyAfluenceLevel;
  late FamilyValues familyValues;
  late FamilyType familyType;

  MatchingProfile.fromJson(json) {
    this.id = json["id"];
    this.email = json["email"];
    this.gender = Gender.values[json["gender"]];
    this.imageUrl = json["imageURL"];
    this.dateOfBirth = json["dateOfBirth"];
    this.name = json["name"];
    this.city = json["careerCity"];
    this.state = json["careerState"];
    this.country = json["careerCountry"];
  }
}

class MatchingProfileResponse {
  late String status, message;
  List<MatchingProfile> list = [];

  MatchingProfileResponse.fromError(String message) {
    this.status = AppConstants.FAILURE;
    this.message = message;
  }

  MatchingProfileResponse.fromJson(json) {
    this.status = json['type'];
    this.message = json["message"];
    this.list = createList(json["data"]);
  }

  List<MatchingProfile> createList(json) {
    List<MatchingProfile> list = [];
    for (var item in json) {
      list.add(MatchingProfile.fromJson(item));
    }
    return list;
  }
}

class ProfileDetails {
  late String id, email, countryCode, dialCode, name, aboutMe, dateOfBirth;
  late Gender gender;
  late Relationship relationship;
  late MaritalStatus maritalStatus;
  late ChildrenStatus childrenStatus;
  late NoOfChildren? noOfChildren;
  late AbilityStatus abilityStatus;
  late String height;

  late DrinkingHabit drinkingHabit;
  late EatingHabit eatingHabit;
  late SmokingHabit smokingHabit;

  late String religion, cast, gothra, motherTongue;
  late Manglik manglik;

  late String occupation, employedin, city, state, country, highiestEducation;
  late AnualIncome annualIncome;
  late FamilyAfluenceLevel familyAfluenceLevel;
  late FamilyType familyType;
  late FamilyValues familyValues;
  late FatherOccupation fatherOccupation;
  late MotherOccupation motherOccupation;
  late int noOfBrother, brothersMarried;
  late int noOfSister, sistersMarried;

  late String familyState, familyCity, familyCountry;
  List<String> images = [];

  ProfileDetails.fromJson(json) {
    this.id = json["id"];
    this.email = json["email"];
    this.countryCode = json["countryCode"];
    this.dialCode = json["phoneNumber"];
    this.gender = Gender.values[json["gender"]];
    this.relationship = Relationship.values[json["relationship"]];
    this.aboutMe = json["userBios"][0]["aboutMe"];
    var aboutMe = json["userAbouts"][0];
    this.name = aboutMe["name"];
    this.dateOfBirth = aboutMe["dateOfBirth"];
    this.maritalStatus = MaritalStatus.values[aboutMe["maritalStatus"]];
    this.childrenStatus = ChildrenStatus.values[aboutMe["childrenStatus"]];
    if (aboutMe["numberOfChildren"] != null) {
      this.noOfChildren = NoOfChildren.values[aboutMe["numberOfChildren"]];
    } else {
      this.noOfChildren = null;
    }
    this.abilityStatus = AbilityStatus.values[aboutMe["abilityStatus"]];
    this.height =
        (double.parse(aboutMe["height"]) / 30.48).toStringAsFixed(1);

    var habit = json["userHabits"][0];

    this.eatingHabit = EatingHabit.values[habit["eatingHabit"]];
    this.smokingHabit = SmokingHabit.values[habit["smokingHabit"]];
    this.drinkingHabit = DrinkingHabit.values[habit["drinkingHabit"]];

    var userReligion = json["userReligions"][0];

    this.religion = userReligion["religion"];
    this.cast = userReligion["cast"];
    this.gothra = userReligion["gothra"];
    this.motherTongue = userReligion["motherTongue"];
    this.manglik = Manglik.values[userReligion["isManglik"]];

    var userCareer = json["userCareers"][0];

    this.occupation = userCareer["occupation"];
    this.employedin = userCareer["employedIn"];
    this.annualIncome = AnualIncome.values[userCareer["annualIncome"]];
    this.country = userCareer["countryName"];
    this.state = userCareer["stateName"];
    this.city = userCareer["cityName"];
    this.highiestEducation = userCareer["highestEducation"];

    var userFamilyBackground = json["userFamilyBackgrounds"][0];

    this.familyAfluenceLevel =
        FamilyAfluenceLevel.values[userFamilyBackground["familyStatus"]];
    this.familyValues =
        FamilyValues.values[userFamilyBackground["familyValues"]];
    this.familyType = FamilyType.values[userFamilyBackground["familyType"]];
    this.familyCountry = userFamilyBackground["countryName"];
    this.familyState = userFamilyBackground["stateName"];
    this.familyCity = userFamilyBackground["cityName"];

    var userFamilyDetail = json["userFamilyDetails"][0];

    this.fatherOccupation =
        FatherOccupation.values[userFamilyDetail["fatherOccupation"]];
    this.motherOccupation =
        MotherOccupation.values[userFamilyDetail["motherOccupation"]];
    this.noOfBrother = userFamilyDetail["numberOfBrothers"];
    this.brothersMarried = userFamilyDetail["marriedNumberOfBrothers"];
    this.noOfSister = userFamilyDetail["numberOfSisters"];
    this.sistersMarried = userFamilyDetail["marriedNumberOfSisters"];
    var userImages = json["userImages"];
    for (var item in userImages) {
      this.images.add(item["imageURL"]);
    }
  }
}

class ProfileDetailsResponse {
  late String status, message;
  late ProfileDetails profileDetails;

  ProfileDetailsResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];
    this.profileDetails = ProfileDetails.fromJson(json["data"]);
  }

  ProfileDetailsResponse.fromError(String message) {
    this.status = AppConstants.FAILURE;
    this.message = message;
  }
}
