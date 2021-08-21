import 'package:makemymarry/utils/app_constants.dart';

class MasterDataResponse {
  MasterData? data;
  late String status;
  late String message;

  MasterDataResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];
    this.data = MasterData.fromJson(json["data"]["profileRawData"]);
  }

  MasterDataResponse.fromError(String message) {
    this.status = AppConstants.FAILURE;
    this.message = message;
  }
}

class MasterData {
  late List<CastSubCast> listCastSubCast;
  late List<Education> listEducation;
  late List<dynamic> listGothra;
  late List<SimpleMasterData> listMotherTongue;
  late List<SimpleMasterData> listPostedBy;
  late List<SimpleMasterData> listReligion;
  late List<Occupation> listOccupation;

  MasterData.fromJson(json) {
    this.listCastSubCast = createCastList(json["castSubCaste"]);
    this.listEducation = createEducationList(json["education"]);
    this.listGothra = json["gothra"];
    this.listMotherTongue = createSimpleMasterDataList(json["motherTongue"]);
    this.listPostedBy = createSimpleMasterDataList(json["postedBy"]);
    this.listReligion = createSimpleMasterDataList(json["religion"]);
    this.listOccupation = createOccupationList(json["occupation"]);
  }

  List<Occupation> createOccupationList(json) {
    List<Occupation> list = [];
    for (var item in json) {
      list.add(Occupation.fromJson(item));
    }
    return list;
  }

  List<Education> createEducationList(json) {
    List<Education> list = [];
    for (var item in json) {
      list.add(Education.fromJson(item));
    }
    return list;
  }

  List<CastSubCast> createCastList(json) {
    List<CastSubCast> list = [];
    for (var item in json) {
      list.add(CastSubCast.fromJson(item));
    }
    return list;
  }

  List<SimpleMasterData> createSimpleMasterDataList(json) {
    List<SimpleMasterData> list = [];
    for (var item in json) {
      list.add(SimpleMasterData.fromJson(item));
    }
    return list;
  }
}

class Occupation {
  late String category;
  late List<SimpleMasterData> subCategory;

  Occupation.fromJson(json) {
    this.category = json["category"];
    this.subCategory = createList(json["subCategory"]);
  }

  List<SimpleMasterData> createList(json) {
    List<SimpleMasterData> list = [];
    for (var item in json) {
      list.add(SimpleMasterData.fromJson(item));
    }
    return list;
  }
}

class SimpleMasterData {
  late String id, title;

  SimpleMasterData.fromJson(json) {
    this.id = json["id"];
    this.title = json["text"];
  }
}

class Education {
  late String id, text, title;

  Education.fromJson(json) {
    this.id = json["id"];
    this.text = json["text"];
    this.title = json["fullform"];
  }
}

class CastSubCast {
  late String cast;
  late List<dynamic> subCasts;

  CastSubCast.fromJson(dynamic json) {
    this.cast = json["cast"];
    this.subCasts = json["subCaste"];
  }
}
