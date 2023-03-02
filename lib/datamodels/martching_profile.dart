import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/profilescreens/profile_preference/profile_preference_bloc.dart';

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
      religion,
      motherTongue,
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
  late ProposalStatus? proposalStatus;
  late String? proposalId, connectId;
  // MatchingProfile.fromError(String error);
  MatchingProfile.fromPremiumJson(json) {
    this.id = json["userBasicId"];
    this.name = json["name"];
    this.city = json["city"];
    this.state = json["state"];
    this.religion = json["religion"] != null ? json["religion"] : "";
    this.motherTongue =
    json["motherTongue"] != null ? json["motherTongue"] : "";
    this.dateOfBirth = json["dateOfBirth"];
    this.imageUrl = json["imageURL"];
    if (json["activationStatus"] != null) {
      this.activationStatus =
          ProfileActivationStatus.values[json["activationStatus"]];
    } else {
      this.activationStatus = ProfileActivationStatus.values[0];
    }
    this.isConnected = json['connectRequestCallMessageStatus']?["isConnectedForCallMessage"] ?? false;
    this.connectId = json['connectRequestCallMessageStatus']?["userConnectRequestId"] ?? "";
    if (json["height"] != null) {
      this.height = (double.parse(json["height"]));
    } else {
      this.height = 0.0;
    }
    this.proposalStatus = (json['UserRequestStatus']?.isNotEmpty ?? false)
        ? (ProposalStatus.values[(json['UserRequestStatus'][0]
                        ["requestedUserBasicId"] !=
                    json['id'] &&
                json['UserRequestStatus'][0]['userRequestStatus'] == 0)
            ? 4
            : json['UserRequestStatus'][0]['userRequestStatus']])
        : null;
    this.proposalId = (json['UserRequestStatus']?.isNotEmpty ?? false)
        ? json['UserRequestStatus'][0]['id']
        : null;
  }
  MatchingProfile.fromRecentViewJson(json) {
    this.id = json["userBasicId"];
    this.name = json["name"];
    this.email = json["email"];
    this.gender = Gender.values[json["gender"]];
    this.religion = json["religion"] != null ? json["religion"] : "";
    this.motherTongue =
    json["motherTongue"] != null ? json["motherTongue"] : "";
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
    if (json["height"] != null) {
      this.height = (double.parse(json["height"]));
    } else {
      this.height = 0.0;
    }
    if (json["activationStatus"] != null) {
      this.activationStatus =
          ProfileActivationStatus.values[json["activationStatus"]];
    } else {
      this.activationStatus = ProfileActivationStatus.values[1];
    }
    this.isConnected = json['connectRequestCallMessageStatus']?["isConnectedForCallMessage"] ?? false;
    this.connectId = json['connectRequestCallMessageStatus']?["userConnectRequestId"] ?? "";
    this.proposalStatus = (json['UserRequestStatus']?.isNotEmpty ?? false)
        ? (ProposalStatus.values[(json['UserRequestStatus'][0]
                        ["requestedUserBasicId"] !=
                    json['id'] &&
                json['UserRequestStatus'][0]['userRequestStatus'] == 0)
            ? 4
            : json['UserRequestStatus'][0]['userRequestStatus']])
        : null;
    this.proposalId = (json['UserRequestStatus']?.isNotEmpty ?? false)
        ? json['UserRequestStatus'][0]['id']
        : null;
  }
  MatchingProfile.fromProfileVisitedJson(json) {
    this.visitedId = json["visitId"];
    this.id = json["id"];
    this.name = json["name"];
    this.email = json["email"];
    this.gender = Gender.values[json["gender"]];
    this.countryCode = json["countryCode"];
    this.dialCode = json["phoneNumber"];
    this.motherTongue =
    json["motherTongue"] != null ? json["motherTongue"] : "";
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
    this.religion = json["religion"] != null ? json["religion"] : "";
    if (json["height"] != null) {
      this.height = (double.parse(json["height"]));
    } else {
      this.height = 0.0;
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
    this.isConnected = json['connectRequestCallMessageStatus']?["isConnectedForCallMessage"] ?? false;
    this.connectId = json['connectRequestCallMessageStatus']?["userConnectRequestId"] ?? "";
    this.proposalStatus = (json['UserRequestStatus']?.isNotEmpty ?? false)
        ? (ProposalStatus.values[(json['UserRequestStatus'][0]
                        ["requestedUserBasicId"] !=
                    json['id'] &&
                json['UserRequestStatus'][0]['userRequestStatus'] == 0)
            ? 4
            : json['UserRequestStatus'][0]['userRequestStatus']])
        : null;
    this.proposalId = (json['UserRequestStatus']?.isNotEmpty ?? false)
        ? json['UserRequestStatus'][0]['id']
        : null;
  }
  MatchingProfile.fromError(String error);
  MatchingProfile.fromJson(json) {
    this.id = json["id"];
    this.email = json["email"];
    this.gender = Gender.values[json["gender"]];
    this.imageUrl = json["imageURL"] ?? "https://i.pravatar.cc/300";
    if (json["dateOfBirth"] != null) {
      this.dateOfBirth = json["dateOfBirth"];
    } else {
      this.dateOfBirth = "";
    }
    if (json["name"] != null) {
      this.name = json["name"];
    } else {
      this.name = "";
    }
    // this.name = json["name"];
    this.caste = json["cast"];
    this.religion = json["religion"] != null ? json["religion"] : "";
    this.motherTongue =
        json["motherTongue"] != null ? json["motherTongue"] : "";
    if (json["height"] != null) {
      this.height = (double.parse(json["height"]));
    } else {
      this.height = 0.0;
    }
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
    this.isConnected = json['connectRequestCallMessageStatus']?["isConnectedForCallMessage"] ?? false;
    this.connectId = json['connectRequestCallMessageStatus']?["userConnectRequestId"] ?? "";
    this.proposalStatus = (json['UserRequestStatus']?.isNotEmpty ?? false)
        ? (ProposalStatus.values[(((json['UserRequestStatus'] is List
            ? json['UserRequestStatus'][0]["requestedUserBasicId"]
            : json['UserRequestStatus']["requestedUserBasicId"]) !=
                        json['id']) &&
                   (json['UserRequestStatus'] is List
                            ? json['UserRequestStatus'][0]['userRequestStatus']
                            : json['UserRequestStatus']['userRequestStatus']) ==
                        0)
                ? 4
                : (json['UserRequestStatus'] is List
                    ? json['UserRequestStatus'][0]['userRequestStatus']
                    : json['UserRequestStatus']['userRequestStatus'])])
        : null;
    this.proposalId = (json['UserRequestStatus']?.isNotEmpty ?? false)
        ? json['UserRequestStatus'] is List
        ? json['UserRequestStatus'][0]['id']
        : json['UserRequestStatus']['id']
        : null;
  }
}

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

class ProfileDetails {
  late String id,
      email,
      mmId,
      countryCode,
      dialCode,
      name,
      aboutMe = "",
      dateOfBirth;
  late Gender gender;
  late Relationship relationship;
  late ProposalStatus? proposalStatus;
  late String? proposalId;
  late bool? connectStatus;
  late String? connectId;
  late bool isBlocked;
  late String blockId;
  late MaritalStatus maritalStatus;
  late ChildrenStatus childrenStatus;
  late NoOfChildren? noOfChildren;
  late AbilityStatus abilityStatus;
  late double height;
  late int cityId;
  late int stateId;
  late String religionId = "";
  late String religionName = "";
  late String casteName;
  late String subCasteName;
  late DrinkingHabit drinkingHabit;
  late EatingHabit eatingHabit;
  late SmokingHabit smokingHabit;
  late SimpleMasterData religionDetails;
  late String religion, cast, gothra;
  late String motherTongue = "";
  late List<String>? lifeStyle;
  late List<String>? hobbies;
  late String motherTongueName = "", motherTongueId = "";
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
    this.activationStatus = ProfileActivationStatus.values[json["activationStatus"] ?? 0];
    this.email = json["email"];
    this.countryCode = json["countryCode"];
    this.dialCode = json["phoneNumber"];
    this.gender = Gender.values[json["gender"]];
    this.relationship = Relationship.values[json["relationship"]];
    if (json["userBios"] != null && json["userBios"].length > 0) {
      this.aboutmeMsg = json["userBios"][0]["aboutMe"];
    }
    if (json["userLifestyle"] != null && json["userLifestyle"].length > 0) {
      this.lifeStyle = json["userLifestyle"][0]["lifestyle"].split(", ");
    } else {
      this.lifeStyle = null;
    }
    if (json["userHobbies"] != null && json["userHobbies"].length > 0) {
      this.hobbies = json["userHobbies"][0]["hobbies"].split(", ");
    }else{
      this.hobbies = null;
    }
    var aboutMe = json["userAbouts"][0];
    this.name = aboutMe["name"];
    this.dateOfBirth = aboutMe["dateOfBirth"];
    this.maritalStatus = MaritalStatus.values[aboutMe["maritalStatus"]];
    this.childrenStatus = ChildrenStatus.values[aboutMe["childrenStatus"]];
    this.proposalStatus = (json['UserRequestStatus']?.isNotEmpty ?? false)
        ? (ProposalStatus.values[(json['UserRequestStatus'][0]
                        ["requestedUserBasicId"] !=
                    json['id'] &&
                json['UserRequestStatus'][0]['userRequestStatus'] == 0)
            ? 4
            : json['UserRequestStatus'][0]['userRequestStatus']])
        : null;
    this.proposalId = (json['UserRequestStatus']?.isNotEmpty ?? false)
        ? json['UserRequestStatus'][0]['id']
        : null;
    this.connectStatus = json['connectRequestCallMessageStatus']?["isConnectedForCallMessage"] ?? false;
    this.connectId = json['connectRequestCallMessageStatus']?["userConnectRequestId"] ?? "";
    this.blockId = json['blockDetails']?["id"] ?? "";
    this.isBlocked = json['blockDetails']?["isBlocked"] ?? false;


    if (aboutMe["numberOfChildren"] != null) {
      this.noOfChildren = NoOfChildren.values[aboutMe["numberOfChildren"]];
    } else {
      this.noOfChildren = null;
    }
    if (aboutMe["abilityStatus"] != null) {
      this.abilityStatus = AbilityStatus.values[aboutMe["abilityStatus"]];
    } else {
      this.abilityStatus = AbilityStatus.Normal;
    }
    this.height = double.parse(aboutMe["height"]);
    if (json["userHabits"] != null && json["userHabits"].length > 0) {
      var habit = json["userHabits"][0];

      this.eatingHabit = EatingHabit.values[habit["eatingHabit"]];
      this.smokingHabit = SmokingHabit.values[habit["smokingHabit"]];
      this.drinkingHabit = DrinkingHabit.values[habit["drinkingHabit"]];
    } else {
      this.eatingHabit = EatingHabit.Notspecified;
      this.smokingHabit = SmokingHabit.Notspecified;
      this.drinkingHabit = DrinkingHabit.Notspecified;
    }
    if (json["userReligions"] != null && json["userReligions"].length > 0) {
      var userReligion = json["userReligions"][0];

      this.religion = userReligion["religion"];

      //this.religionDetails = userReligion["religion"];
      this.cast = userReligion["cast"];
      this.religionId =  userReligion['religionId'] != null && userReligion['religionId'].length > 0 ? userReligion['religionId'][0]["id"] : "";

      this.gothra =
          userReligion["gothra"] != null ? userReligion["gothra"] : "";
      // userReligion["gothra"];
      this.motherTongue = userReligion["motherTongue"];
      this.motherTongueId = userReligion["motherTongueId"] ?? "";
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
      this.familyAfluenceLevel = FamilyAfluenceLevel.NotMentioned;
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
      if (!this.images.contains(item["imageURL"])) {
        if (item["isDefault"] == true) {
          this.images.insert(0, item["imageURL"]);
        } else {
          this.images.add(item["imageURL"]);
        }
      }
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


class PartnerPreferenceResponse {
  late String status, message;
  late PartnerPreferences preferences;

  PartnerPreferenceResponse.fromJson(
      json,) {
    this.status =  AppConstants.SUCCESS;
    this.message = json["message"];

      this.preferences =
          PartnerPreferences.fromJson(json: json["data"]);

  }

  PartnerPreferenceResponse.fromError(String message) {
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
