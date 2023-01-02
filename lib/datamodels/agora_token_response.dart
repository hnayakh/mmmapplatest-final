import 'dart:convert';

import 'package:makemymarry/utils/app_constants.dart';

class AgoraTokenResponse {
  late String message, status;
  late AgoraToken? token;


  AgoraTokenResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];
    print(this.status);
    if (this.status == AppConstants.SUCCESS) {
       token =  AgoraToken.fromJson(json["data"])  ;
    }
  }

  AgoraTokenResponse.fromError(String error) {
    print('we are in json error');
    this.message = error;
    this.status = AppConstants.FAILURE;
  }
}

AgoraToken agoraTokenFromJson(String str) => AgoraToken.fromJson(json.decode(str));

String agoraTokenToJson(AgoraToken data) => json.encode(data.toJson());

class AgoraToken {
  AgoraToken({
    required this.agoraToken,
    required this.channelName,
    required this.notificationId,
    required this.name,
    required this.profileImage,
  });

  String agoraToken;
  String channelName;
  String notificationId;
  String name;
  String profileImage;

  factory AgoraToken.fromJson(Map<String, dynamic> json) => AgoraToken(
    agoraToken: json["agoraToken"],
    channelName: json["channelName"],
    notificationId: json["notificationId"],
    name: json["name"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "agoraToken": agoraToken,
    "channelName": channelName,
    "notificationId": notificationId,
    "name": name,
    "profileImage": profileImage,
  };
}
