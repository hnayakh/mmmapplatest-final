import 'dart:convert';

import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/preference_helper.dart';

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
            userDetails!.motherTongue = SimpleMasterData("", "")
              ..id = extraData[0]["motherTongue"]
              ..title = extraData[0]["motherTongue"];
          } else {
            userDetails!.motherTongue = SimpleMasterData("", "")
              ..id = 'unknown'
              ..title = 'UNK';
          }
          if (extraData[0]["dateOfBirth"] != null) {
            userDetails!.dateOfBirth = extraData[0]["dateOfBirth"];
          } else {
            userDetails!.dateOfBirth = '';
          }
          if (extraData[0]["height"] != null) {
            userDetails!.height = double.parse(extraData[0]["height"]);
          } else {
            userDetails!.height = 64;
          }
          if (extraData[0]["maritalStatus"] != null) {
            userDetails!.maritalStatus =
                MaritalStatus.values[extraData[0]["maritalStatus"]];
          } else {
            userDetails!.maritalStatus = MaritalStatus.NeverMarried;
          }

          if (extraData[0]["careerCountryId"] != null) {
            userDetails!.countryModel = CountryModel()
              ..id = extraData[0]["careerCountryId"]
              ..name = extraData[0]["careerCountry"]
              ..shortName = extraData[0]["careerCountry"];
          } else {


            for (var country in PreferenceHelper.countryList) {
              if (json["data"]["userBasic"]["countryCode"] ==
                  country["phoneCode"].toString()) {
                print('success found match');
                userDetails!.countryModel = CountryModel()
                  ..id = country["id"]
                  ..name = country["name"]
                  ..shortName = country["shortName"];
              }
            }
          }
          if (extraData[0]["religion"] != null) {
            userDetails!.religion = SimpleMasterData("", "")
              ..id = extraData[0]["religion"]
              ..title = extraData[0]["religion"];
          } else {
            userDetails!.religion = SimpleMasterData("", "")
              ..id = 'unknown'
              ..title = 'UNK';
          }
          if (extraData[0]["abilityStatus"] != null) {
            userDetails!.abilityStatus =
                AbilityStatus.values[extraData[0]["abilityStatus"]];
          } else {
            userDetails!.abilityStatus = AbilityStatus.Normal;
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
  late String id, email, mobile, dialCode, displayId, name, imageUrl;
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
    this.displayId = json["displayId"];
    this.name =  json["name"] ?? "";
    this.imageUrl =  json["imageUrl"] ?? "";
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
    this.displayId,
    this.id,
    this.name,
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
    this.imageUrl,
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

class CheckEmailResponse {
  late String message, status;

  CheckEmailResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];
  }

  CheckEmailResponse.fromError(String error) {
    this.message = error;
    this.status = AppConstants.FAILURE;
  }
}

class DocumentUploadResponse {
  late String message, status;
  late String id, idProof;

  DocumentUploadResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];
    this.id = json["data"]?["id"] ?? "";
    this.idProof = json["data"]?["idProof"] ?? "";
  }

  DocumentUploadResponse.fromError(String error) {
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

class CreateMeetResponse {
  late String status, message;
  late CreateMeetData? data;


  CreateMeetResponse.fromJson(json) {
    print(json["message"]);
    this.status = json["type"];
    this.message = json["message"];
    this.data = CreateMeetData.fromJson(json['data']);
  }

  CreateMeetResponse.fromError(String error) {
    this.status = AppConstants.FAILURE;
    this.message = error;
    this.data = null;
  }
}

class SettingsDataResponse {
  late String status, message;
  late SettingsData? data;


  SettingsDataResponse.fromJson(json) {
    print(json["message"]);
    this.status = json["type"];
    this.message = json["message"];
    this.data = SettingsData.fromJson(json['data']);
  }

  SettingsDataResponse.fromError(String error) {
    this.status = AppConstants.FAILURE;
    this.message = error;
    this.data = null;
  }
}


class SettingsData {
  final String id;
  final DateTime? createdAt;
  final String createdBy;
  final DateTime? updatedAt;
  final String updatedBy;
  final bool isActive;
  final int status;
  final bool showPhone;
  final bool showEmail;
  final bool isHidden;
  final bool isNotification;

  const SettingsData({
    required this.id,
     this.createdAt,
    required this.createdBy,
     this.updatedAt,
    required this.updatedBy,
    required this.isActive,
    required this.status,
    required this.showPhone,
    required this.showEmail,
    required this.isHidden,
    required this.isNotification,
  });

  factory SettingsData.fromRawJson(String str) => SettingsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SettingsData.fromJson(Map<String, dynamic> json) => SettingsData(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    createdBy: json["createdBy"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    updatedBy: json["updatedBy"],
    isActive: json["isActive"],
    status: json["status"],
    showPhone: json["showPhone"],
    showEmail: json["showEmail"],
    isHidden: json["isHidden"],
    isNotification: json["isNotification"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt?.toIso8601String(),
    "createdBy": createdBy,
    "updatedAt": updatedAt?.toIso8601String(),
    "updatedBy": updatedBy,
    "isActive": isActive,
    "status": status,
    "showPhone": showPhone,
    "showEmail": showEmail,
    "isHidden": isHidden,
    "isNotification": isNotification,
  };
}

class CreateMeetData {
  CreateMeetData({
    required this.status,
    required this.scheduleTime,
    required this.requestedId,
    required this.requestingId,
    required this.address,
    required this.link,
    required this.lat,
    required this.long,
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.isActive,
  });

  final dynamic status;
  final DateTime scheduleTime;
  final String requestedId;
  final String requestingId;
  final String address;
  final String link;
  final String lat;
  final String long;
  final String id;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  final bool isActive;

  factory CreateMeetData.fromRawJson(String str) => CreateMeetData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateMeetData.fromJson(Map<String, dynamic> json) => CreateMeetData(
    status: json["status"],
    scheduleTime: DateTime.parse(json["scheduleTime"]),
    requestedId: json["requestedId"],
    requestingId: json["requestingId"],
    address: json["address"],
    link: json["link"],
    lat: json["lat"]?.toString() ?? '0.0',
    long: json["long"]?.toString() ?? '0.0' ,
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    createdBy: json["createdBy"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    updatedBy: json["updatedBy"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "scheduleTime": scheduleTime.toIso8601String(),
    "requestedId": requestedId,
    "requestingId": requestingId,
    "address": address,
    "link": link,
    "lat": lat,
    "long": long,
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "createdBy": createdBy,
    "updatedAt": updatedAt.toIso8601String(),
    "updatedBy": updatedBy,
    "isActive": isActive,
  };
}


class MeetListResponse {
  late String status, message;
  late MeetListData? data;


  MeetListResponse.fromJson(json) {
    print(json["message"]);
    this.status = json["type"];
    this.message = json["message"];
    this.data = MeetListData.fromJson(json['data']);
  }

  MeetListResponse.fromError(String error) {
    this.status = AppConstants.FAILURE;
    this.message = error;
    this.data = null;
  }
}



class MeetListData {
  MeetListData({
    required this.activeSent,
    required this.activeconnections,
    required this.activeInvites,
  });

  final List<Activeconnection> activeSent;
  final List<Activeconnection> activeconnections;
  final List<Activeconnection> activeInvites;



  factory MeetListData.fromRawJson(String str) => MeetListData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MeetListData.fromJson(Map<String, dynamic> json) => MeetListData(
    activeSent:List<Activeconnection>.from(json["activeSent"].map((x) => Activeconnection.fromJson(x))),
    activeconnections: List<Activeconnection>.from(json["activeconnections"].map((x) => Activeconnection.fromJson(x))),
    activeInvites: List<Activeconnection>.from(json["activeInvites"].map((x) => Activeconnection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "activeSent": List<dynamic>.from(activeSent.map((x) => x)),
    "activeconnections": List<dynamic>.from(activeconnections.map((x) => x.toJson())),
    "activeInvites": List<dynamic>.from(activeInvites.map((x) => x)),
  };
}

class Activeconnection {
  Activeconnection({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.isActive,
    required this.status,
    required this.lat,
    required this.long,
    required this.type,
    required this.requestedId,
    required this.requestingId,
    required this.link,
    required this.scheduleTime,
    required this.address,
    required this.requestedUserDeatails,
    required this.user,
  });

  final String id;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;
  final bool isActive;
  final int status;
  final double lat;
  final double long;
  final String type;
  final String requestedId;
  final String requestingId;
  final String link;
  final DateTime scheduleTime;
  final String address;
  final RequestedUserDeatails requestedUserDeatails;
  final RequestedUserDeatails user;



  factory Activeconnection.fromRawJson(String str) => Activeconnection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Activeconnection.fromJson(Map<String, dynamic> json) => Activeconnection(
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    createdBy: json["createdBy"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    updatedBy: json["updatedBy"],
    isActive: json["isActive"],
    status: json["status"],
    lat: double.parse(json["lat"].toString()),
    long: double.parse(json["long"].toString()),
    type: json["type"],
    requestedId: json["requestedId"],
    requestingId: json["requestingId"],
    link: json["link"],
    scheduleTime: DateTime.parse(json["scheduleTime"]),
    address: json["address"],
    requestedUserDeatails: RequestedUserDeatails.fromJson(json["requestedUserDeatails"]),
    user: RequestedUserDeatails.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "createdBy": createdBy,
    "updatedAt": updatedAt.toIso8601String(),
    "updatedBy": updatedBy,
    "isActive": isActive,
    "status": status,
    "lat": lat,
    "long": long,
    "type": type,
    "requestedId": requestedId,
    "requestingId": requestingId,
    "link": link,
    "scheduleTime": scheduleTime.toIso8601String(),
    "address": address,
    "requestedUserDeatails": requestedUserDeatails.toJson(),
    "user": user.toJson(),
  };
}

class RequestedUserDeatails {
  RequestedUserDeatails({
    required this.id,
    required this.email,
    required this.gender,
    required this.countryCode,
    required this.phoneNumber,
    required this.registrationStep,
    required this.activationStatus,
    required this.lifecycleStatus,
    required this.createdAt,
    required this.displayId,
    required this.relationship,
    required this.isActive,
    required this.name,
    required this.dateOfBirth,
    required this.age,
    required this.maritalStatus,
    required this.childrenStatus,
    required this.abilityStatus,
    required this.height,
    required this.eatingHabit,
    required this.smokingHabit,
    required this.drinkingHabit,
    required this.religion,
    required this.cast,
    required this.gothra,
    required this.motherTongue,
    required this.isManglik,
    required this.employedIn,
    required this.occupation,
    required this.annualIncome,
    required this.highestEducation,
    required this.careerCountryId,
    required this.careerCountry,
    required this.careerState,
    required this.careerCity,
    required this.familyStatus,
    required this.familyValues,
    required this.familyType,
    required this.familyCountry,
    required this.familyState,
    required this.familyCity,
    required this.fatherOccupation,
    required this.motherOccupation,
    required this.numberOfBrothers,
    required this.marriedNumberOfBrothers,
    required this.numberOfSisters,
    required this.marriedNumberOfSisters,
    required this.aboutMe,
    required this.imageUrl,
    required this.thumbnailUrl,
  });

  final String id;
  final dynamic email;
  final dynamic gender;
  final dynamic countryCode;
  final dynamic phoneNumber;
  final dynamic registrationStep;
  final dynamic activationStatus;
  final dynamic lifecycleStatus;
  final dynamic createdAt;
  final dynamic displayId;
  final dynamic relationship;
  final dynamic isActive;
  final String name;
  final dynamic dateOfBirth;
  final dynamic age;
  final dynamic maritalStatus;
  final dynamic childrenStatus;
  final dynamic abilityStatus;
  final dynamic height;
  final dynamic eatingHabit;
  final dynamic smokingHabit;
  final dynamic drinkingHabit;
  final dynamic religion;
  final dynamic cast;
  final dynamic gothra;
  final dynamic motherTongue;
  final dynamic isManglik;
  final dynamic employedIn;
  final dynamic occupation;
  final dynamic annualIncome;
  final dynamic highestEducation;
  final dynamic careerCountryId;
  final dynamic careerCountry;
  final dynamic careerState;
  final dynamic careerCity;
  final dynamic familyStatus;
  final dynamic familyValues;
  final dynamic familyType;
  final dynamic familyCountry;
  final dynamic familyState;
  final dynamic familyCity;
  final dynamic fatherOccupation;
  final dynamic motherOccupation;
  final dynamic numberOfBrothers;
  final dynamic marriedNumberOfBrothers;
  final dynamic numberOfSisters;
  final dynamic marriedNumberOfSisters;
  final dynamic aboutMe;
  final String imageUrl;
  final String thumbnailUrl;




  factory RequestedUserDeatails.fromRawJson(String str) => RequestedUserDeatails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestedUserDeatails.fromJson(Map<String, dynamic> json) => RequestedUserDeatails(
    id: json["id"],
    email: json["email"],
    gender: json["gender"],
    countryCode: json["countryCode"],
    phoneNumber: json["phoneNumber"],
    registrationStep: json["registrationStep"],
    activationStatus: json["activationStatus"],
    lifecycleStatus: json["lifecycleStatus"],
    createdAt: DateTime.parse(json["createdAt"]),
    displayId: json["displayId"],
    relationship: json["relationship"],
    isActive: json["isActive"],
    name: json["name"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    age: json["age"],
    maritalStatus: json["maritalStatus"],
    childrenStatus: json["childrenStatus"],
    abilityStatus: json["abilityStatus"],
    height: json["height"],
    eatingHabit: json["eatingHabit"],
    smokingHabit: json["smokingHabit"],
    drinkingHabit: json["drinkingHabit"],
    religion: json["religion"],
    cast: json["cast"],
    gothra: json["gothra"],
    motherTongue: json["motherTongue"],
    isManglik: json["isManglik"],
    employedIn: json["employedIn"],
    occupation: json["occupation"],
    annualIncome: json["annualIncome"],
    highestEducation: json["highestEducation"],
    careerCountryId: json["careerCountryId"],
    careerCountry: json["careerCountry"],
    careerState: json["careerState"],
    careerCity: json["careerCity"] ?? "",
    familyStatus: json["familyStatus"],
    familyValues: json["familyValues"],
    familyType: json["familyType"],
    familyCountry: json["familyCountry"],
    familyState: json["familyState"],
    familyCity: json["familyCity"] ?? "",
    fatherOccupation: json["fatherOccupation"],
    motherOccupation: json["motherOccupation"],
    numberOfBrothers: json["numberOfBrothers"],
    marriedNumberOfBrothers: json["marriedNumberOfBrothers"],
    numberOfSisters: json["numberOfSisters"],
    marriedNumberOfSisters: json["marriedNumberOfSisters"],
    aboutMe: json["aboutMe"],
    imageUrl: json["imageURL"],
    thumbnailUrl: json["thumbnailURL"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "gender": gender,
    "countryCode": countryCode,
    "phoneNumber": phoneNumber,
    "registrationStep": registrationStep,
    "activationStatus": activationStatus,
    "lifecycleStatus": lifecycleStatus,
    "createdAt": createdAt.toIso8601String(),
    "displayId": displayId,
    "relationship": relationship,
    "isActive": isActive,
    "name": name,
    "dateOfBirth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "age": age,
    "maritalStatus": maritalStatus,
    "childrenStatus": childrenStatus,
    "abilityStatus": abilityStatus,
    "height": height,
    "eatingHabit": eatingHabit,
    "smokingHabit": smokingHabit,
    "drinkingHabit": drinkingHabit,
    "religion": religion,
    "cast": cast,
    "gothra": gothra,
    "motherTongue": motherTongue,
    "isManglik": isManglik,
    "employedIn": employedIn,
    "occupation": occupation,
    "annualIncome": annualIncome,
    "highestEducation": highestEducation,
    "careerCountryId": careerCountryId,
    "careerCountry": careerCountry,
    "careerState": careerState,
    "careerCity": careerCity,
    "familyStatus": familyStatus,
    "familyValues": familyValues,
    "familyType": familyType,
    "familyCountry": familyCountry,
    "familyState": familyState,
    "familyCity": familyCity,
    "fatherOccupation": fatherOccupation,
    "motherOccupation": motherOccupation,
    "numberOfBrothers": numberOfBrothers,
    "marriedNumberOfBrothers": marriedNumberOfBrothers,
    "numberOfSisters": numberOfSisters,
    "marriedNumberOfSisters": marriedNumberOfSisters,
    "aboutMe": aboutMe,
    "imageURL": imageUrl,
    "thumbnailURL": thumbnailUrl,
  };
}
