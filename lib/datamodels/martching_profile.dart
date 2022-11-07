import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class MatchingProfile {
  late String id,
      email,
      visitedId,
      name,
      mmId,
      dialCode,
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
      age,
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
  late ProfileActivationStatus activationStatus;

  late bool isConnected;
  late InterestRequest requestStatus;
  late String? requestId, connectId;
  // MatchingProfile.fromError(String error);
  MatchingProfile.fromPremiumJson(json) {
    this.id = json["userBasicId"];
    this.name = json["name"];
    this.city = json["city"];
    this.state = json["state"];
    this.dateOfBirth = json["dateOfBirth"];
    this.imageUrl = json["imageURL"];
    if (json["activationStatus"] != null) {
      this.activationStatus =
          ProfileActivationStatus.values[json["activationStatus"]];
    } else {
      this.activationStatus = ProfileActivationStatus.values[1];
    }
    if (json["connectStatus"] != null) {
      this.isConnected = json["connectStatus"]["isConnected"];
      if (this.isConnected) {
        this.connectId = json["connectStatus"]["id"];
      }
    } else {
      this.isConnected = false;
    }
    if (json["interestStatus"] != null) {
      this.requestId = json["interestStatus"]["id"];
      if (json["interestStatus"]["isLiked"]) {
        this.requestStatus = InterestRequest.Accepted;
      } else if (json["interestStatus"]["sent"]) {
        this.requestStatus = InterestRequest.Sent;
      } else if (json["interestStatus"]["requested"]) {
        this.requestStatus = InterestRequest.Received;
      } else {
        this.requestStatus = InterestRequest.NotConnected;
      }
    } else {
      this.requestStatus = InterestRequest.NotConnected;
    }
  }
  MatchingProfile.fromRecentViewJson(json) {
    this.id = json["userBasicId"];
    this.name = json["name"];
    this.email = json["email"];
    this.gender = Gender.values[json["gender"]];
    this.countryCode = json["countryCode"];
    this.dialCode = json["phoneNumber"];
    this.mmId = json["displayId"];
    this.aboutMe = json["aboutMe"];
    this.dateOfBirth = json["dateOfBirth"];
    this.imageUrl = json["imageURL"];
    if (json["careerCity"] != null) {
      this.city = json["careerCity"];
    } else {
      this.city = "";
    }
    if (json['careerState'] != null) {
      this.state = json['careerState'];
    } else {
      this.state = "";
    }
    if (json["activationStatus"] != null) {
      this.activationStatus =
          ProfileActivationStatus.values[json["activationStatus"]];
    } else {
      this.activationStatus = ProfileActivationStatus.values[1];
    }
    if (json["connectStatus"] != null) {
      this.isConnected = json["connectStatus"]["isConnected"];
      if (this.isConnected) {
        this.connectId = json["connectStatus"]["id"];
      }
    } else {
      this.isConnected = false;
    }
    if (json["interestStatus"] != null) {
      this.requestId = json["interestStatus"]["id"];
      if (json["interestStatus"]["isLiked"]) {
        this.requestStatus = InterestRequest.Accepted;
      } else if (json["interestStatus"]["sent"]) {
        this.requestStatus = InterestRequest.Sent;
      } else if (json["interestStatus"]["requested"]) {
        this.requestStatus = InterestRequest.Received;
      } else {
        this.requestStatus = InterestRequest.NotConnected;
      }
    } else {
      this.requestStatus = InterestRequest.NotConnected;
    }
  }
  MatchingProfile.fromProfileVisitedJson(json) {
    this.visitedId = json["visitId"];
    this.id = json["id"];
    this.name = json["name"];
    this.email = json["email"];
    this.gender = Gender.values[json["gender"]];
    this.countryCode = json["countryCode"];
    this.dialCode = json["phoneNumber"];
    this.mmId = json["displayId"];
    this.aboutMe = json["aboutMe"];
    this.dateOfBirth = json["dateOfBirth"];
    this.imageUrl = json["imageURL"];
    this.age = json["age"];
    if (json["careerCity"] != null) {
      this.city = json["careerCity"];
    } else {
      this.city = "";
    }
    if (json['careerState'] != null) {
      this.state = json['careerState'];
    } else {
      this.state = "";
    }
    if (json["activationStatus"] != null) {
      this.activationStatus =
          ProfileActivationStatus.values[json["activationStatus"]];
    } else {
      this.activationStatus = ProfileActivationStatus.values[1];
    }
    if (json["connectStatus"] != null) {
      this.isConnected = json["connectStatus"]["isConnected"];
      if (this.isConnected) {
        this.connectId = json["connectStatus"]["id"];
      }
    } else {
      this.isConnected = false;
    }
    if (json["interestStatus"] != null) {
      this.requestId = json["interestStatus"]["id"];
      if (json["interestStatus"]["isLiked"]) {
        this.requestStatus = InterestRequest.Accepted;
      } else if (json["interestStatus"]["sent"]) {
        this.requestStatus = InterestRequest.Sent;
      } else if (json["interestStatus"]["requested"]) {
        this.requestStatus = InterestRequest.Received;
      } else {
        this.requestStatus = InterestRequest.NotConnected;
      }
    } else {
      this.requestStatus = InterestRequest.NotConnected;
    }
  }
  MatchingProfile.fromError(String error);
  MatchingProfile.fromJson(json) {
    this.id = json["id"];
    this.email = json["email"];
    this.gender = Gender.values[json["gender"]];
    this.imageUrl = json["imageURL"];
    this.dateOfBirth = json["dateOfBirth"];
    this.name = json["name"];
    if (json["careerCity"] != null && json["careerCity"] != Null) {
      this.city = json["careerCity"];
    }
    if (json["careerState"] != null) {
      this.state = json["careerState"]!;
    } else {
      this.state = "";
    }
    if (json["careerCountry"] != null) {
      this.city = json["careerCity"];
    } else {
      this.city = "";
    }
    if (json["careerCountry"] != null) {
      this.country = json["careerCountry"];
    } else {
      this.country = "";
    }
    this.activationStatus =
        ProfileActivationStatus.values[json["activationStatus"]];
    if (json["connectStatus"] != null) {
      this.isConnected = json["connectStatus"]["isConnected"];
      if (this.isConnected) {
        this.connectId = json["connectStatus"]["id"];
      }
    } else {
      this.isConnected = false;
    }
    if (json["interestStatus"] != null) {
      this.requestId = json["interestStatus"]["id"];
      if (json["interestStatus"]["isLiked"]) {
        this.requestStatus = InterestRequest.Accepted;
      } else if (json["interestStatus"]["sent"]) {
        this.requestStatus = InterestRequest.Sent;
      } else if (json["interestStatus"]["requested"]) {
        this.requestStatus = InterestRequest.Received;
      } else {
        this.requestStatus = InterestRequest.NotConnected;
      }
    } else {
      this.requestStatus = InterestRequest.NotConnected;
    }
  }
}

// class PremiumMembers {
//   late String id, name, religion, city, state, dateOfBirth, imageURL;
//   MatchingProfile.fromError(String error);
//   MatchingProfile.fromPremiumJson(json) {
//     this.id = json["id"];
//     this.name = json["name"];
//     this.religion = json["religion"];
//     this.city = json["city"];
//     this.state = json["state"];
//     this.dateOfBirth = json["dateOfBirth"];
//     this.imageURL = json["imageURL"];
//   }
// }

class MatchingProfileSearch {
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
  late ProfileActivationStatus activationStatus;

  late bool isConnected;
  late InterestRequest requestStatus;
  late String? requestId, connectId;

  MatchingProfileSearch.fromJson(json) {
    print('here');
    this.id = json["id"];
    this.email = json["email"];
    this.gender = Gender.values[json["gender"]];
    this.imageUrl = json["imageURL"];
    this.dateOfBirth = json["dateOfBirth"];
    this.name = json["name"];
    // this.city = json["careerCity"];
    // this.state = json["careerState"];
    // this.country = json["careerCountry"];
    this.activationStatus =
        ProfileActivationStatus.values[json["activationStatus"]];
    if (json["connectStatus"] != null) {
      this.isConnected = json["connectStatus"]["isConnected"];
      if (this.isConnected) {
        this.connectId = json["connectStatus"]["id"];
      }
    } else {
      this.isConnected = false;
    }
    if (json["interestStatus"] != null) {
      this.requestId = json["interestStatus"]["id"];
      if (json["interestStatus"]["isLiked"]) {
        this.requestStatus = InterestRequest.Accepted;
      } else if (json["interestStatus"]["sent"]) {
        this.requestStatus = InterestRequest.Sent;
      } else if (json["interestStatus"]["requested"]) {
        this.requestStatus = InterestRequest.Received;
      } else {
        this.requestStatus = InterestRequest.NotConnected;
      }
    } else {
      this.requestStatus = InterestRequest.NotConnected;
    }
  }
}

enum InterestRequest { NotConnected, Sent, Received, Accepted }

class MatchingProfileResponse {
  late String status, message;
  List<MatchingProfile> list = [];
  // List<PremiumMembers> list = [];

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

class PremiumMembersResponse {
  late String status, message;
  List<MatchingProfile> list = [];

  PremiumMembersResponse.fromError(String message) {
    this.status = AppConstants.FAILURE;
    this.message = message;
  }

  PremiumMembersResponse.fromJson(json) {
    this.status = json['type'];
    this.message = json["message"];
    this.list = createList(json["data"]);
  }

  List<MatchingProfile> createList(json) {
    List<MatchingProfile> list = [];
    for (var item in json) {
      list.add(MatchingProfile.fromPremiumJson(item));
    }
    return list;
  }
}

class ProfileVisitedResponse {
  late String status, message;
  List<MatchingProfile> list = [];

  ProfileVisitedResponse.fromError(String message) {
    this.status = AppConstants.FAILURE;
    this.message = message;
  }

  ProfileVisitedResponse.fromJson(json) {
    this.status = json['type'];
    this.message = json["message"];
    this.list = createList(json["data"]);
  }

  List<MatchingProfile> createList(json) {
    List<MatchingProfile> list = [];
    for (var item in json) {
      list.add(MatchingProfile.fromProfileVisitedJson(item));
    }
    return list;
  }
}

class RecentViewsResponse {
  late String status, message;
  List<MatchingProfile> list = [];

  RecentViewsResponse.fromError(String message) {
    this.status = AppConstants.FAILURE;
    this.message = message;
  }

  RecentViewsResponse.fromJson(json) {
    this.status = json['type'];
    this.message = json["message"];
    this.list = createList(json["data"]);
  }

  List<MatchingProfile> createList(json) {
    List<MatchingProfile> list = [];
    for (var item in json) {
      list.add(MatchingProfile.fromRecentViewJson(item));
    }
    return list;
  }
}

// class ProfileVisitedResponse {
//   late String status, message;
//   List<MatchingProfile> list = [];

//   ProfileVisitedResponse.fromError(String message) {
//     this.status = AppConstants.FAILURE;
//     this.message = message;
//   }

//   ProfileVisitedResponse.fromJson(json) {
//     this.status = json['type'];
//     this.message = json["message"];
//     this.list = createList(json["data"]);
//   }

//   List<MatchingProfile> createList(json) {
//     List<MatchingProfile> list = [];
//     for (var item in json) {
//       list.add(MatchingProfile.fromProfileVisitedJson(item));
//     }
//     return list;
//   }
// }

class MatchingProfileSearchResponse {
  late String status, message;
  List<MatchingProfileSearchResponse> searchList = [];

  MatchingProfileSearchResponse.fromError(String message) {
    this.status = AppConstants.FAILURE;
    this.message = message;
  }

  MatchingProfileSearchResponse.fromJson(json) {
    this.status = json['type'];
    this.message = json["message"];
    this.searchList = createSearchList(json["data"]);
  }

  List<MatchingProfileSearchResponse> createSearchList(json) {
    List<MatchingProfileSearchResponse> searchList = [];
    for (var item in json) {
      searchList.add(MatchingProfileSearchResponse.fromJson(item));
    }
    return searchList;
  }
}

class ProfileDetails {
  late String id,
      email,
      mmId,
      countryCode,
      dialCode,
      name,
      aboutMe,
      dateOfBirth;
  late Gender gender;
  late Relationship relationship;
  late MaritalStatus maritalStatus;
  late ChildrenStatus childrenStatus;
  late NoOfChildren? noOfChildren;
  late AbilityStatus abilityStatus;
  late String height;
  late int cityId;
  late int stateId;
  late String religionId;
  late String religionName;
  late String casteName;
  late String subCasteName;
  late DrinkingHabit drinkingHabit;
  late EatingHabit eatingHabit;
  late SmokingHabit smokingHabit;
  late SimpleMasterData religionDetails;
  late String religion, cast, gothra, motherTongue;
  late String motherTongueName, motherTongueId;
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
  late int familyStateId, familyCityId;
  List<String> images = [];
  late String aboutmeMsg = "";
  late ProfileActivationStatus activationStatus;
  ProfileDetails() {}
  ProfileDetails.fromJson(json, ProfileActivationStatus activationStatus) {
    this.id = json["id"];
    this.mmId = json["displayId"];
    this.activationStatus = activationStatus;
    this.email = json["email"];
    this.countryCode = json["countryCode"];
    this.dialCode = json["phoneNumber"];
    this.gender = Gender.values[json["gender"]];
    this.relationship = Relationship.values[json["relationship"]];
    if (json["userBios"] != null && json["userBios"].length > 0) {
      this.aboutmeMsg = json["userBios"][0]["aboutMe"];
    }
    var aboutMe = json["userAbouts"][0];
    this.name = aboutMe["name"];
    this.dateOfBirth = aboutMe["dateOfBirth"];
    this.maritalStatus = MaritalStatus.values[aboutMe["maritalStatus"]];
    this.childrenStatus = ChildrenStatus.values[aboutMe["childrenStatus"]];
    if (json["userReligions"] != null && json["userReligions"].length > 0) {
      this.religionId = json["userReligions"][0]["religionId"][0]["id"];
      this.religionName = json["userReligions"][0]["religionId"][0]["text"];
    } else {
      this.religionName = "";
      this.religionId = "";
    }
    if (aboutMe["numberOfChildren"] != null) {
      this.noOfChildren = NoOfChildren.values[aboutMe["numberOfChildren"]];
    } else {
      this.noOfChildren = null;
    }
    this.abilityStatus = AbilityStatus.values[aboutMe["abilityStatus"]];
    this.height = (double.parse(aboutMe["height"]) / 30.48).toStringAsFixed(1);

    var habit = json["userHabits"][0];

    this.eatingHabit = EatingHabit.values[habit["eatingHabit"]];
    this.smokingHabit = SmokingHabit.values[habit["smokingHabit"]];
    this.drinkingHabit = DrinkingHabit.values[habit["drinkingHabit"]];
    if (json["userReligions"] != null && json["userReligions"].length > 0) {
      var userReligion = json["userReligions"][0];

      this.religion = userReligion["religion"];
      //this.religionDetails = userReligion["religion"];
      this.cast = userReligion["cast"];
      this.casteName = userReligion["casteName"];
      this.subCasteName = userReligion["subCasteName"];
      this.gothra = userReligion["gothra"];
      // userReligion["gothra"];
      this.motherTongue = userReligion["motherTongue"];
      this.motherTongueId = userReligion["motherTongueId"];
      this.manglik = Manglik.values[userReligion["isManglik"]];
    } else {
      this.religion = "";
      this.cast = "";
      this.casteName = "";
      this.subCasteName = "";
      this.gothra = "";
      this.motherTongue = "";
      this.motherTongueId = "";
      this.manglik = Manglik.No;
    }

    if (json["userCareers"] != null && json["userCareers"].length > 0) {
      var userCareer = json["userCareers"][0];
      if (userCareer["occupation"] != null) {
        this.occupation = userCareer["occupation"];
      } else {
        this.occupation = "";
      }
      this.employedin = userCareer["employedIn"];
      this.annualIncome = AnualIncome.values[userCareer["annualIncome"]];
      this.country = userCareer["countryName"];
      this.state = userCareer["stateName"];
      this.stateId = userCareer["state"];
      this.city = userCareer["cityName"];
      this.cityId = userCareer["city"];
      this.highiestEducation = userCareer["highestEducation"];
    } else {
      this.occupation = "";
      this.annualIncome = AnualIncome.NoIncome;
      this.city = "";
      this.state = "";
      this.country = "";
      this.highiestEducation = "";
      this.employedin = "";
      this.cityId = -1;
      this.stateId = -1;
    }
    if (json["userFamilyBackgrounds"].length > 0) {
      var userFamilyBackground = json["userFamilyBackgrounds"][0];

      this.familyAfluenceLevel =
          FamilyAfluenceLevel.values[userFamilyBackground["familyStatus"]];
      this.familyValues =
          FamilyValues.values[userFamilyBackground["familyValues"]];
      this.familyType = FamilyType.values[userFamilyBackground["familyType"]];
      this.familyCountry = userFamilyBackground["countryName"];
      this.familyState = userFamilyBackground["stateName"];
      this.familyStateId = userFamilyBackground["state"];
      this.familyCity = userFamilyBackground["cityName"];
      this.familyCityId = userFamilyBackground["city"];
    } else {
      this.familyAfluenceLevel = FamilyAfluenceLevel.MiddleClass;
      this.familyValues = FamilyValues.NotMentioned;
      this.familyType = FamilyType.Notmentioned;
      this.familyCountry = "";
      this.familyState = "";
      this.familyCity = "";
      this.familyCityId = -1;
      this.familyStateId = -1;
    }
    if (json["userFamilyDetails"].length > 0) {
      var userFamilyDetail = json["userFamilyDetails"][0];

      this.fatherOccupation =
          FatherOccupation.values[userFamilyDetail["fatherOccupation"]];
      this.motherOccupation =
          MotherOccupation.values[userFamilyDetail["motherOccupation"]];
      this.noOfBrother = userFamilyDetail["numberOfBrothers"];
      this.brothersMarried = userFamilyDetail["marriedNumberOfBrothers"];
      this.noOfSister = userFamilyDetail["numberOfSisters"];
      this.sistersMarried = userFamilyDetail["marriedNumberOfSisters"];
    } else {
      this.fatherOccupation = FatherOccupation.NotEmployed;
      this.motherOccupation = MotherOccupation.HomeMaker;
      this.noOfBrother = 0;
      this.brothersMarried = 0;

      this.noOfSister = 0;
      this.sistersMarried = 0;
    }
    var userImages = json["userImages"];
    for (var item in userImages) {
      this.images.add(item["imageURL"]);
    }
  }
}

class ProfileDetailsResponse {
  late String status, message;
  late ProfileDetails profileDetails;

  ProfileDetailsResponse.fromJson(
      json, ProfileActivationStatus activationStatus) {
    this.status = json["type"];
    this.message = json["message"];
    if (json["message"] != "No user found for given DisplayId") {
      this.profileDetails =
          ProfileDetails.fromJson(json["data"], activationStatus);
    }
  }

  ProfileDetailsResponse.fromError(String message) {
    this.status = AppConstants.FAILURE;
    this.message = message;
  }
}

class LikeStatusResponse {
  late String status, message;

  LikeStatusResponse.fromJson(json) {
    this.message = json['message'];
    this.status = json["type"];
  }

  LikeStatusResponse.fromError(error) {
    this.status = AppConstants.FAILURE;
    this.message = error;
  }
}
