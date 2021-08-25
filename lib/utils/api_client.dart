import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

import 'app_helper.dart';

class ApiClient {
  final Dio dio = Dio();

  ApiClient() {
    dio.interceptors.add(dioLoggerInterceptor);
  }

  Future<RegistrationResponse> registerUser(
      int? profileCreatedFor,
      String email,
      String phoneCode,
      String mobile,
      Gender? gender,
      String password) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/basic", data: {
        "email": email,
        "gender": gender!.index,
        "countryCode": phoneCode,
        "phoneNumber": mobile,
        "password": password,
        "relationship": profileCreatedFor
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegistrationResponse.fromJson(response.data);
      } else {
        return RegistrationResponse.fromError(
            "Error Occurred. Please try againa.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return RegistrationResponse.fromError(
          "Error Occurred. Please try againa.");
    }
  }

  Future<SigninResponse> signinUser(String email, String password) async {
    try {
      Response response = await this.dio.post(
          AppConstants.ENDPOINT + "auth/login",
          data: {"email": email, "password": password});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SigninResponse.fromJson(response.data);
      } else {
        return SigninResponse.fromError("Error Occurred. Please try againa.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Error Occurred. Please try againa.");
    }
  }

  Future<SigninResponse> aboutVerification(
      MaritalStatus? maritalStatus,
      AbilityStatus? abilityStatus,
      ChildrenStatus? childrenStatus,
      int? heightStatus,
      String? dob,
      String? name,
      String userId) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/about", data: {
        "userBasicId": userId,
        "name": name,
        "dateOfBirth": dob,
        "maritalStatus": maritalStatus!.index,
        "childrenStatus": childrenStatus!.index,
        "abilityStatus": abilityStatus!.index,
        "height": AppHelper.getHeights()[heightStatus!]
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SigninResponse.fromJson(response.data);
      } else {
        return SigninResponse.fromError("Error Occurred. Please try againa.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Error Occurred. Please try againa.");
    }
  }

  Future<MasterDataResponse> getMasterData(String? userId) async {
    try {
      Response response = await this.dio.get(
          AppConstants.ENDPOINT + "masters/profile-raw-data",
          queryParameters: userId != null ? {"userBasicId": userId} : {});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return MasterDataResponse.fromJson(response.data);
      } else {
        return MasterDataResponse.fromError(
            "Error Occurred. Please try againa.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return MasterDataResponse.fromError("Error Occurred. Please try againa.");
    }
  }

  Future<SigninResponse> habitVerification(EatingHabit eatingHabit,
      SmokingHabit smokingHabit, DrinkingHabit drinkingHabit, String id) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/habit", data: {
        "userBasicId": id,
        "eatingHabit": eatingHabit.index,
        "smokingHabit": smokingHabit.index,
        "drinkingHabit": drinkingHabit.index
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SigninResponse.fromJson(response.data);
      } else {
        return SigninResponse.fromError("Error Occurred. Please try againa.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Error Occurred. Please try againa.");
    }
  }

  Future<SigninResponse> verifyOtp(
      String dialCode, String mobile, OtpType otpType, String otp) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "auth/verifyOtp", data: {
        "countryCode": dialCode,
        "phoneNumber": mobile,
        "type": otpType.index,
        "email": "rutuparna.rout@gmail.com",
        "otp": "123456"
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SigninResponse.fromJson(response.data);
      } else {
        return SigninResponse.fromError("Error Occurred. Please try againa.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Error Occurred. Please try againa.");
    }
  }

  Future<SendOtpResponse> sendOtp(String dialCode, String mobile) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "auth/sendOtp", data: {
        "countryCode": dialCode,
        "phoneNumber": mobile,
        "type": OtpType.Login.index,
        "email": "rutuparna.rout@gmail.com",
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SendOtpResponse.fromJson(response.data);
      } else {
        return SendOtpResponse.fromError("Error Occurred. Please try againa.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SendOtpResponse.fromError("Error Occurred. Please try againa.");
    }
  }

  Future<SigninResponse> updateReligion(
      SimpleMasterData religion,
      CastSubCast caste,
      String subCaste,
      SimpleMasterData motherTongue,
      gothra,
      Manglik isManglik,
      String id) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/religion", data: {
        "userBasicId": id,
        "religion": religion.id,
        "cast": caste.cast,
        "subCast": subCaste,
        "motherTongue": motherTongue.id,
        "isManglik": isManglik.index
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SigninResponse.fromJson(response.data);
      } else {
        return SigninResponse.fromError("Error Occurred. Please try againa.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Error Occurred. Please try againaa.");
    }
  }

  Future<SigninResponse> careerVerification(
      String nameOfOrg,
      String? occupation,
      String income,
      Education? education,
      String country,
      String stateName,
      String city,
      String id) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/career", data: {
        "userBasicId": id,
        "employedIn": nameOfOrg,
        "occupation": occupation,
        "annualIncome": income,
        "highestEducation": education,
        "country": country,
        "state": stateName,
        "city": city
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SigninResponse.fromJson(response.data);
      } else {
        return SigninResponse.fromError("Error Occurred. Please try againa.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Error Occurred. Please try againa.");
    }
  }
}
