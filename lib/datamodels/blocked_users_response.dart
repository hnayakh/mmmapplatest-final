// To parse this JSON data, do
//
//     final blockedUsersResponse = blockedUsersResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import '../utils/app_constants.dart';

class BlockedUsersResponse {
  BlockedUsersResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.type,
  });

  final int status;
  final String message;
  final List<BlockedUser> data;
  final String type;

  factory BlockedUsersResponse.fromRawJson(String str) =>
      BlockedUsersResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlockedUsersResponse.fromJson(Map<String, dynamic> json) =>
      BlockedUsersResponse(
        status: json["status"],
        message: json["message"],
        data: List<BlockedUser>.from(
            json["data"].map((x) => BlockedUser.fromJson(x))),
        type: json["type"],
      );
  factory BlockedUsersResponse.fromError(String message) =>
      BlockedUsersResponse(
          status: 0, message: message, data: [], type: AppConstants.FAILURE);

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "type": type,
      };
}

class BlockedUser {
  BlockedUser({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.isActive,
    required this.blockWho,
    required this.blockWhom,
    required this.user,
  });

  final String id;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  final bool isActive;
  final String blockWho;
  final String blockWhom;
  final BlockUserDetails user;

  factory BlockedUser.fromRawJson(String str) =>
      BlockedUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlockedUser.fromJson(Map<String, dynamic> json) => BlockedUser(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        blockWho: json["block_who"],
        blockWhom: json["block_whom"],
        user: BlockUserDetails.fromJson(json["block_user_details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
        "isActive": isActive,
        "block_who": blockWho,
        "block_whom": blockWhom,
        "block_user_details": user.toJson(),
      };
}

class BlockUserDetails {
  BlockUserDetails({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.isActive,
    required this.relationship,
    required this.email,
    required this.gender,
    required this.countryCode,
    required this.phoneNumber,
    required this.password,
    required this.displayId,
    required this.activationStatus,
    required this.lifecycleStatus,
    required this.fireBaseToken,
    required this.registrationStep,
    required this.userBios,
    required this.userAbouts,
    required this.userHabits,
    required this.userReligions,
    required this.userCareers,
    required this.userFamilyBackgrounds,
    required this.userFamilyDetails,
    required this.userImages,
  });

  final String id;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  final bool isActive;
  final int relationship;
  final String email;
  final int gender;
  final String countryCode;
  final String phoneNumber;
  final String password;
  final String displayId;
  final int activationStatus;
  final int lifecycleStatus;
  final String fireBaseToken;
  final int registrationStep;
  final List<UserBio> userBios;
  final List<UserAbout> userAbouts;
  final List<UserHabit> userHabits;
  final List<UserReligion> userReligions;
  final List<UserCareer> userCareers;
  final List<dynamic> userFamilyBackgrounds;
  final List<dynamic> userFamilyDetails;
  final List<UserImage> userImages;

  factory BlockUserDetails.fromRawJson(String str) =>
      BlockUserDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlockUserDetails.fromJson(Map<String, dynamic> json) =>
      BlockUserDetails(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        relationship: json["relationship"],
        email: json["email"],
        gender: json["gender"],
        countryCode: json["countryCode"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        displayId: json["displayId"],
        activationStatus: json["activationStatus"],
        lifecycleStatus: json["lifecycleStatus"],
        fireBaseToken: json["fireBaseToken"],
        registrationStep: json["registrationStep"],
        userBios: List<UserBio>.from(
            json["userBios"].map((x) => UserBio.fromJson(x))),
        userAbouts: List<UserAbout>.from(
            json["userAbouts"].map((x) => UserAbout.fromJson(x))),
        userHabits: List<UserHabit>.from(
            json["userHabits"].map((x) => UserHabit.fromJson(x))),
        userReligions: List<UserReligion>.from(
            json["userReligions"].map((x) => UserReligion.fromJson(x))),
        userCareers: List<UserCareer>.from(
            json["userCareers"].map((x) => UserCareer.fromJson(x))),
        userFamilyBackgrounds:
            List<dynamic>.from(json["userFamilyBackgrounds"].map((x) => x)),
        userFamilyDetails:
            List<dynamic>.from(json["userFamilyDetails"].map((x) => x)),
        userImages: List<UserImage>.from(
            json["userImages"].map((x) => UserImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
        "isActive": isActive,
        "relationship": relationship,
        "email": email,
        "gender": gender,
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
        "password": password,
        "displayId": displayId,
        "activationStatus": activationStatus,
        "lifecycleStatus": lifecycleStatus,
        "fireBaseToken": fireBaseToken,
        "registrationStep": registrationStep,
        "userBios": List<dynamic>.from(userBios.map((x) => x.toJson())),
        "userAbouts": List<dynamic>.from(userAbouts.map((x) => x.toJson())),
        "userHabits": List<dynamic>.from(userHabits.map((x) => x.toJson())),
        "userReligions":
            List<dynamic>.from(userReligions.map((x) => x.toJson())),
        "userCareers": List<dynamic>.from(userCareers.map((x) => x.toJson())),
        "userFamilyBackgrounds":
            List<dynamic>.from(userFamilyBackgrounds.map((x) => x)),
        "userFamilyDetails":
            List<dynamic>.from(userFamilyDetails.map((x) => x)),
        "userImages": List<dynamic>.from(userImages.map((x) => x.toJson())),
      };
}

class UserAbout {
  UserAbout({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.isActive,
    required this.name,
    required this.dateOfBirth,
    required this.fireBaseToken,
    required this.maritalStatus,
    required this.childrenStatus,
    required this.numberOfChildren,
    required this.abilityStatus,
    required this.profileUpdationStatus,
    required this.height,
  });

  final String id;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  final bool isActive;
  final String name;
  final DateTime dateOfBirth;
  final String fireBaseToken;
  final int maritalStatus;
  final int childrenStatus;
  final int numberOfChildren;
  final int abilityStatus;
  final int profileUpdationStatus;
  final String height;

  factory UserAbout.fromRawJson(String str) =>
      UserAbout.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserAbout.fromJson(Map<String, dynamic> json) => UserAbout(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        name: json["name"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        fireBaseToken: json["fireBaseToken"],
        maritalStatus: json["maritalStatus"],
        childrenStatus: json["childrenStatus"],
        numberOfChildren: json["numberOfChildren"],
        abilityStatus: json["abilityStatus"],
        profileUpdationStatus: json["profileUpdationStatus"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
        "isActive": isActive,
        "name": name,
        "dateOfBirth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "fireBaseToken": fireBaseToken,
        "maritalStatus": maritalStatus,
        "childrenStatus": childrenStatus,
        "numberOfChildren": numberOfChildren,
        "abilityStatus": abilityStatus,
        "profileUpdationStatus": profileUpdationStatus,
        "height": height,
      };
}

class UserBio {
  UserBio({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.isActive,
    required this.aboutMe,
    required this.profileUpdationStatus,
  });

  final String id;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  final bool isActive;
  final String aboutMe;
  final int profileUpdationStatus;

  factory UserBio.fromRawJson(String str) => UserBio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserBio.fromJson(Map<String, dynamic> json) => UserBio(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        aboutMe: json["aboutMe"],
        profileUpdationStatus: json["profileUpdationStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
        "isActive": isActive,
        "aboutMe": aboutMe,
        "profileUpdationStatus": profileUpdationStatus,
      };
}

class UserCareer {
  UserCareer({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.isActive,
    required this.employedIn,
    required this.occupation,
    required this.annualIncome,
    required this.highestEducation,
    required this.country,
    required this.state,
    required this.city,
    required this.profileUpdationStatus,
  });

  final String id;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  final bool isActive;
  final String employedIn;
  final String occupation;
  final int annualIncome;
  final String highestEducation;
  final String country;
  final String state;
  final String city;
  final int profileUpdationStatus;

  factory UserCareer.fromRawJson(String str) =>
      UserCareer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserCareer.fromJson(Map<String, dynamic> json) => UserCareer(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        employedIn: json["employedIn"],
        occupation: json["occupation"],
        annualIncome: json["annualIncome"],
        highestEducation: json["highestEducation"],
        country: json["countryName"].toString(),
        state: json["stateName"].toString(),
        city: json["cityName"].toString(),
        profileUpdationStatus: json["profileUpdationStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
        "isActive": isActive,
        "employedIn": employedIn,
        "occupation": occupation,
        "annualIncome": annualIncome,
        "highestEducation": highestEducation,
        "countryName": country.toString(),
        "stateName": state.toString(),
        "cityName": city.toString(),
        "profileUpdationStatus": profileUpdationStatus,
      };
}

class UserHabit {
  UserHabit({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.isActive,
    required this.eatingHabit,
    required this.smokingHabit,
    required this.drinkingHabit,
    required this.profileUpdationStatus,
  });

  final String id;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  final bool isActive;
  final int eatingHabit;
  final int smokingHabit;
  final int drinkingHabit;
  final int profileUpdationStatus;

  factory UserHabit.fromRawJson(String str) =>
      UserHabit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserHabit.fromJson(Map<String, dynamic> json) => UserHabit(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        eatingHabit: json["eatingHabit"],
        smokingHabit: json["smokingHabit"],
        drinkingHabit: json["drinkingHabit"],
        profileUpdationStatus: json["profileUpdationStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
        "isActive": isActive,
        "eatingHabit": eatingHabit,
        "smokingHabit": smokingHabit,
        "drinkingHabit": drinkingHabit,
        "profileUpdationStatus": profileUpdationStatus,
      };
}

class UserImage {
  UserImage({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.isActive,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.isDefault,
    required this.profileUpdationStatus,
  });

  final String id;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  final bool isActive;
  final String imageUrl;
  final String thumbnailUrl;
  final bool isDefault;
  final int profileUpdationStatus;

  factory UserImage.fromRawJson(String str) =>
      UserImage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserImage.fromJson(Map<String, dynamic> json) => UserImage(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        imageUrl: json["imageURL"],
        thumbnailUrl: json["thumbnailURL"],
        isDefault: json["isDefault"],
        profileUpdationStatus: json["profileUpdationStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
        "isActive": isActive,
        "imageURL": imageUrl,
        "thumbnailURL": thumbnailUrl,
        "isDefault": isDefault,
        "profileUpdationStatus": profileUpdationStatus,
      };
}

class UserReligion {
  UserReligion({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.isActive,
    required this.religion,
    required this.cast,
    required this.gothra,
    required this.motherTongue,
    required this.isManglik,
    required this.profileUpdationStatus,
  });

  final String id;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  final bool isActive;
  final String religion;
  final String cast;
  final String gothra;
  final String motherTongue;
  final int isManglik;
  final int profileUpdationStatus;

  factory UserReligion.fromRawJson(String str) =>
      UserReligion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserReligion.fromJson(Map<String, dynamic> json) => UserReligion(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        updatedBy: json["updatedBy"],
        isActive: json["isActive"],
        religion: json["religion"],
        cast: json["cast"],
        gothra: json["gothra"],
        motherTongue: json["motherTongue"],
        isManglik: json["isManglik"],
        profileUpdationStatus: json["profileUpdationStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "createdBy": createdBy,
        "updatedAt": updatedAt.toIso8601String(),
        "updatedBy": updatedBy,
        "isActive": isActive,
        "religion": religion,
        "cast": cast,
        "gothra": gothra,
        "motherTongue": motherTongue,
        "isManglik": isManglik,
        "profileUpdationStatus": profileUpdationStatus,
      };
}
