import 'package:makemymarry/utils/app_constants.dart';

class InterestResponse {
  late final String status;
  late final String message;
  late final Data data;

  InterestResponse.fromJson(Map<String, dynamic> json) {
    status = json['type'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
  InterestResponse.fromError(String error) {
    this.status = AppConstants.FAILURE;
    this.message = error;
  }
}

class Data {
  late final List<ActiveInterests> activeSent;
  late final List<ActiveInterests> activeconnections;
  late final List<ActiveInterests> activeInvites;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['activeSent'] != []) {
      activeSent = List.from(json['activeSent'])
          .map((e) => ActiveInterests.fromJson(e))
          .toList();
    } else {
      activeSent = [];
    }

    if (json['activeconnections'] != []) {
      activeconnections = List.from(json['activeconnections'])
          .map((e) => ActiveInterests.fromJson(e))
          .toList();
    } else {
      activeconnections = [];
    }
    if (json['activeInvites'] != []) {
      activeInvites = List.from(json['activeInvites'])
          .map((e) => ActiveInterests.fromJson(e))
          .toList();
    } else {
      activeInvites = [];
    }
  }
}

class ActiveInterests {
  late final String id;
  late final String createdAt;
  late final String createdBy;
  late final String updatedAt;
  late final String updatedBy;
  late final bool isActive;
  late final String requestingUserBasicId;
  late final String requestedUserBasicId;
  late final int userRequestStatus;
  late final int userRequestState;
  late final String requestDate;
  late final String acceptanceRejectionDate;
  late final int operation;
  late final RequestDetails requestedUserDeatails;
  late final RequestDetails requestingUserDeatails;

  ActiveInterests.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    createdAt = json['createdAt'] ?? '';
    createdBy = json['createdBy'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    updatedBy = json['updatedBy'] ?? '';
    isActive = json['isActive'] ?? '';
    requestingUserBasicId = json['requestingUserBasicId'] ?? '';
    requestedUserBasicId = json['requestedUserBasicId'] ?? '';
    userRequestStatus = json['userRequestStatus'] ?? -1;
    userRequestState = json['userRequestState'] ?? -1;
    requestDate = json['requestDate'] ?? '';
    acceptanceRejectionDate = json['acceptanceRejectionDate'] ?? '';
    operation = json['operation'] ?? -1;
    requestedUserDeatails =
        RequestDetails.fromJson(json['requestedUserDeatails']);
    requestingUserDeatails =
        RequestDetails.fromJson(json['requestingUserDeatails']);
  }
}

class RequestDetails {
  late final int gender;
  late final int registrationStep;
  late final int activationStatus;
  late final int lifecycleStatus;
  late final int relationship;
  late final int isActive;
  late final int age;
  late final int maritalStatus;
  late final int childrenStatus;
  late final int abilityStatus;
  late final int eatingHabit;
  late final int smokingHabit;
  late final int drinkingHabit;
  late final int isManglik;
  late final int fatherOccupation;
  late final int motherOccupation;
  late final int numberOfBrothers;
  late final int marriedNumberOfBrothers;
  late final int numberOfSisters;
  late final int marriedNumberOfSisters;
  late final int familyValues;
  late final int familyType;
  late final int familyStatus;
  late final int careerCountryId;

  late final String countryCode;
  late final String phoneNumber;
  late final String id;
  late final String email;
  late final String createdAt;
  late final String displayId;

  late final String name;
  late final String dateOfBirth;

  late final String height;

  late final String religion;
  late final String cast;
  late final String gothra;
  late final String motherTongue;

  late final String employedIn;
  late final String occupation;
  late final int annualIncome;
  late final String highestEducation;

  late final String careerCountry;
  late final String careerState;
  late final String careerCity;

  late final String familyCountry;
  late final String familyState;
  late final String familyCity;

  late final String aboutMe;
  late final String imageURL;
  late final String thumbnailURL;

  RequestDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';

    email = json['email'] ?? '';
    gender = json['gender'] ?? -1;
    countryCode = json['countryCode'] ?? -1;
    phoneNumber = json['phoneNumber'] ?? -1;
    registrationStep = json['registrationStep'] ?? -1;
    activationStatus = json['activationStatus'] ?? -1;
    lifecycleStatus = json['lifecycleStatus'] ?? -1;
    createdAt = json['createdAt'] ?? '';
    displayId = json['displayId'] ?? '';
    relationship = json['relationship'] ?? -1;
    isActive = json['isActive'] ?? -1;
    name = json['name'] ?? '';
    dateOfBirth = json['dateOfBirth'] ?? '';
    age = json['age'] ?? -1;
    maritalStatus = json['maritalStatus'] ?? -1;
    childrenStatus = json['childrenStatus'] ?? -1;
    abilityStatus = json['abilityStatus'] ?? -1;
    height = json['height'] ?? '';
    eatingHabit = json['eatingHabit'] ?? -1;
    smokingHabit = json['smokingHabit'] ?? -1;
    drinkingHabit = json['drinkingHabit'] ?? -1;
    religion = json['religion'] ?? '';
    cast = json['cast'] ?? '';
    gothra = json['gothra'] ?? '';
    motherTongue = json['motherTongue'] ?? '';
    isManglik = json['isManglik'] ?? -1;
    employedIn = json['employedIn'] ?? '';
    occupation = json['occupation'] ?? '';
    annualIncome = json['annualIncome'] ?? '';
    highestEducation = json['highestEducation'] ?? '';
    careerCountryId = json['careerCountryId'] ?? -1;
    careerCountry = json['careerCountry'] ?? '';
    careerState = json['careerState'] ?? '';
    careerCity = json['careerCity'] ?? '';
    familyStatus = json['familyStatus'] ?? -1;
    familyValues = json['familyValues'] ?? -1;
    familyType = json['familyType'] ?? -1;
    familyCountry = json['familyCountry'] ?? '';
    familyState = json['familyState'] ?? '';
    familyCity = json['familyCity'] ?? '';
    fatherOccupation = json['fatherOccupation'] ?? -1;
    motherOccupation = json['motherOccupation'] ?? -1;
    numberOfBrothers = json['numberOfBrothers'] ?? -1;
    marriedNumberOfBrothers = json['marriedNumberOfBrothers'] ?? -1;
    numberOfSisters = json['numberOfSisters'] ?? -1;
    marriedNumberOfSisters = json['marriedNumberOfSisters'] ?? -1;
    aboutMe = json['aboutMe'] ?? '';
    imageURL = json['imageURL'] ?? '';
    thumbnailURL = json['thumbnailURL'] ?? '';
  }
}
