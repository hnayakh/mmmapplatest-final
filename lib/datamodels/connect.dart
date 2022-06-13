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
