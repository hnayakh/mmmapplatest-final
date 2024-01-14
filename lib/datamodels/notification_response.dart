import 'dart:convert';

import '../utils/app_constants.dart';

class NotificationResponse {
  NotificationResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.type,
  });

  final int status;
  final String message;
  final List<Notification> data;
  final String type;

  factory NotificationResponse.fromRawJson(String str) =>
      NotificationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        status: json["status"],
        message: json["message"],
        data: List<Notification>.from(
            json["data"].map((x) => Notification.fromJson(x))),
        type: json["type"],
      );

  factory NotificationResponse.fromError(String message) =>
      NotificationResponse(
          status: 0, message: message, data: [], type: AppConstants.FAILURE);

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "type": type,
      };
}

class Notification {
  Notification({
    required this.id,
    required this.createdAt,
    required this.message,
    required this.header,
    required this.image,
  });

  final String id;
  final DateTime createdAt;
  final String message;
  final String header;
  final String image;

  factory Notification.fromRawJson(String str) =>
      Notification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        message: json["message"],
        header: json["header"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "message": message,
        "header": header,
        "image": image,
      };
}
