import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/app_helper.dart';

class CouponDetails {
  late String id, code;
  late bool isActive;
  late int discountType;
  late double discount;
  late String validTill;

  CouponDetails.fromJson(dynamic json) {
    this.id = json["id"];
    this.code = json["couponCode"];
    this.discountType = json["discountType"];
    this.discount = (json["discount"]).toDouble();
    this.validTill = json["validTill"];
    this.isActive = json["isActive"];
  }
}

class CouponDetailsResponse {
  late String status, message;
  CouponDetails? couponDetails;

  CouponDetailsResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];

    if (this.status == AppConstants.SUCCESS) {
      this.couponDetails = CouponDetails.fromJson(json["data"]);
    }
  }

  CouponDetailsResponse.fromError(String mesage) {
    this.status = AppConstants.FAILURE;
    this.message = mesage;
  }
}

class ConnectPriceDetails {
  late double connectPrice, discount, discountedPrice;
  late int firstTimeBenefit, secondTimeBenefit;

  ConnectPriceDetails.fromJson(json) {
    this.connectPrice = json["connectPrice"].toDouble();
    this.discount = json["discount"].toDouble();
    this.discountedPrice = json["discountedPrice"].toDouble();
    this.firstTimeBenefit = json["firstTimeBenifitMins"];
    this.secondTimeBenefit = json["secondTimeBenifitMins"];
  }
}

class ConnectPriceDetailsResponse {
  late String status, message;
  ConnectPriceDetails? couponDetails;

  ConnectPriceDetailsResponse.fromJson(json) {
    this.status = json["type"];
    this.message = json["message"];

    if (this.status == AppConstants.SUCCESS) {
      this.couponDetails =
          ConnectPriceDetails.fromJson((json["data"] as List).last);
    }
  }

  ConnectPriceDetailsResponse.fromError(String mesage) {
    this.status = AppConstants.FAILURE;
    this.message = mesage;
  }
}

class RechargeModel {
  dynamic data;

  RechargeModel(
      double totalAmount,
      double discount,
      int connectCount,
      double grandTotal,
      String transactionId,
      String userId,
      CouponDetails? couponDetails) {
    this.data = {
      "actualAmount": grandTotal,
      "discountedAmount": discount,
      "isCouponApplied": couponDetails != null,
      "couponCode": couponDetails != null ? couponDetails.code : '',
      "amount": totalAmount,
      "connectCount": connectCount,
      "date": DateTime.now().toString(),
      "modeOfPayment": couponDetails != null ? couponDetails.discountType : 1,
      //discount type
      "transactionId": transactionId,
      "failureReason": "",
      "userBasicId": userId,
      "paymentStatus": 0
    };
  }
}

class CurrentBalanceResponse {
  late String status, message;
  late int balance;

  CurrentBalanceResponse.fromJson(data) {
    this.status = data["type"];
    this.message = data["message"];
    if (data["data"] != null) {
      this.balance = data["data"]["connectBalance"];
    } else {
      this.balance = 0;
    }
  }

  CurrentBalanceResponse.fromError(String message) {
    this.status = AppConstants.FAILURE;
    this.message = message;
    this.balance = 0;
  }
}
