import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class MyConnectResponse extends SimpleResponse {
  List<MyConnectItem> list = [];

  MyConnectResponse.fromError(String error) : super.fromError(error);

  MyConnectResponse.fromJson(json) : super.fromJson(json) {
    this.list = createList(json["data"]);
  }

  List<MyConnectItem> createList(json) {
    List<MyConnectItem> list = [];
    for (var item in json) {
      list.add(MyConnectItem.fromJson(item));
    }
    return list;
  }
}

class MyConnectItem {
  late String connectId, userId, displayId, name, imageURL, thumbnailURL;
  late ActivationStatus activationStatus;

  MyConnectItem.fromJson(json) {
    this.connectId = json["connectId"];
    this.userId = json["userId"];
    this.displayId = json["displayId"];
    this.activationStatus = ActivationStatus.values[json["activationStatus"]];
    this.imageURL = json["imageURL"];
    this.thumbnailURL = json["thumbnailURL"];
    this.name = json["name"];
  }
}

class ConnectHistoryResponse extends SimpleResponse {
  List<ConnectHistoryItem> list = [];

  ConnectHistoryResponse.fromJson(data) : super.fromJson(data) {
    this.list = createList(data["data"]);
  }
  ConnectHistoryResponse.fromError(String error) : super.fromError(error);
  List<ConnectHistoryItem> createList(data) {
    List<ConnectHistoryItem> list = [];
    for (var item in data) {
      list.add(ConnectHistoryItem.fromJson(item));
    }
    return list;
  }
}

class ConnectHistoryItem {
  var data = {
    "transactionId": "682f26a1-cdc8-45ae-aeb4-8a0bfe21d1cc",
    "updatedAt": "2022-06-12T13:24:58.000Z",
    "transactionType": 0,
    "userId": "65516ef0-b73f-4244-b6c6-853630fa3fd9",
    "displayId": "RFKzb3lGJ",
    "activationStatus": 1,
    "name": "Pc",
    "imageURL":
        "https://mmm-user-image.s3.ap-south-1.amazonaws.com/65516ef0-b73f-4244-b6c6-853630fa3fd9/BBoJULddQ_scaled_image_picker4745448398030063991.jpg",
    "thumbnailURL":
        "https://mmm-user-image.s3.ap-south-1.amazonaws.com/65516ef0-b73f-4244-b6c6-853630fa3fd9/BBoJULddQ_scaled_image_picker4745448398030063991.jpg"
  };
  late String transactionId, updatedAt, userId, displayId, name, thumbnailURL;
  late int transactionType;
  late ActivationStatus activationStatus;

  ConnectHistoryItem.fromJson(data) {
    this.thumbnailURL = data["thumbnailURL"];
    this.updatedAt = data["updatedAt"];
    this.transactionType = data["transactionType"];
    this.userId = data["userId"];
    this.displayId = data["displayId"];
    this.name = data["name"];
    this.name = data["name"];
    this.activationStatus = data["activationStatus"] != null
        ? ActivationStatus.values[data["activationStatus"]]
        : ActivationStatus.Pending;
  }
}

class MySearchResponse extends SimpleResponse {
  List<MatchingProfileSearch> searchList = [];

  MySearchResponse.fromError(String error) : super.fromError(error);

  MySearchResponse.fromJson(json) : super.fromJson(json) {
    this.searchList = createList(json["data"]);
    print('JONTY');
    print(this.searchList);
  }

  List<MatchingProfileSearch> createList(json) {
    List<MatchingProfileSearch> newlist = [];
    for (var item in json) {
      newlist.add(MatchingProfileSearch.fromJson(item));
    }
    return newlist;
  }
}

class MySeachItem {
  late String connectId, userId, displayId, name, imageURL, thumbnailURL;
  late ActivationStatus activationStatus;

  MySeachItem.fromJson(json) {
    this.connectId = json["connectId"];
    this.userId = json["userId"];
    this.displayId = json["displayId"];
    this.activationStatus = ActivationStatus.values[json["activationStatus"]];
    this.imageURL = json["imageURL"];
    this.thumbnailURL = json["thumbnailURL"];
    this.name = json["name"];
  }
}
