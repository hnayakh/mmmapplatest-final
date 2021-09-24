import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/profile_data.dart';
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
      NoOfChildren? noOfChildren,
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
        "height": AppHelper.getHeights()[heightStatus!],
        "numberOfChildren": noOfChildren == null ? null : noOfChildren.index
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

  Future<ProfileDataResponse> getAllUsersProfileData(String userId) async {
    try {
      Response response = await this.dio.get(
            AppConstants.ENDPOINT + "users/profiles/$userId",
          );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProfileDataResponse.fromJson(response.data);
      } else {
        return ProfileDataResponse.fromError(
            "Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      print('the error is..');
      print(error);
      return ProfileDataResponse.fromError("Error Occurred. Please try again.");
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
        "countryCode": "+$dialCode",
        "phoneNumber": mobile,
        "type": otpType.index,
        "email": "",
        "otp": otp
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SigninResponse.fromJson(response.data, otpType: otpType);
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

  Future<SigninResponse> verifyOtpEmail(String email, String otp) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "auth/verifyOtp", data: {
        "countryCode": "",
        "phoneNumber": "",
        "type": OtpType.ForgotPassword.index,
        "email": email,
        "otp": otp
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

  Future<SendOtpResponse> sendOtp(
      String dialCode, String mobile, OtpType login) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "auth/sendOtp", data: {
        "countryCode": "+$dialCode",
        "phoneNumber": mobile,
        "type": login.index,
        "email": "",
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

  Future<SendOtpResponse> sendOtpEmail(String email) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "auth/sendOtp", data: {
        "countryCode": "",
        "phoneNumber": "",
        "type": OtpType.ForgotPassword.index,
        "email": email,
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
        "cast": subCaste,
        "motherTongue": motherTongue.id,
        "gothra": gothra,
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

  Future<SigninResponse> updateBio(String aboutMe, List<String> images, String id) async {
    try {
      Response response = await this.dio.post(
          AppConstants.ENDPOINT + "users/bio",
          data: {"userBasicId": id, "aboutMe": aboutMe, "userImages": images});
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
      String? education,
      CountryModel country,
      StateModel stateName,
      StateModel city,
      String id) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/career", data: {
        "userBasicId": id,
        "employedIn": nameOfOrg,
        "occupation": occupation,
        "annualIncome": income,
        "highestEducation": education,
        "country": country.id,
        "state": stateName.id,
        "city": city.id
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

  Future<CountryResponse> getCountryList() async {
    try {
      Response response = await this.dio.get(
            AppConstants.ENDPOINT + "masters/countries",
          );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CountryResponse.fromJson(response.data);
      }
      return CountryResponse.fromError("Error Occurred. Please try againa.");
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return CountryResponse.fromError("Error Occurred. Please try againa.");
    }
  }

  Future<StateCityResponse> getState(int id) async {
    try {
      Response response = await this.dio.get(
            AppConstants.ENDPOINT + "masters/states/$id",
          );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return StateCityResponse.fromJson(response.data);
      }
      return StateCityResponse.fromError("Error Occurred. Please try againa.");
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return StateCityResponse.fromError("Error Occurred. Please try againa.");
    }
  }

  Future<StateCityResponse> getCity(int id) async {
    try {
      Response response = await this.dio.get(
            AppConstants.ENDPOINT + "masters/cities/$id",
          );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return StateCityResponse.fromJson(response.data);
      }
      return StateCityResponse.fromError("Error Occurred. Please try againa.");
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return StateCityResponse.fromError("Error Occurred. Please try againa.");
    }
  }

  Future<SigninResponse> updateFamilyBackground(
      FamilyAfluenceLevel familyAfluenceLevel,
      FamilyValues familyValues,
      FamilyType type,
      CountryModel countryModel,
      StateModel state,
      StateModel city,
      String id) async {
    try {
      Response response = await this
          .dio
          .post(AppConstants.ENDPOINT + "users/familyBackground", data: {
        "userBasicId": id,
        "familyStatus": familyValues.index,
        "familyValues": familyValues.index,
        "familyType": type.index,
        "country": countryModel.id,
        "state": state.id,
        "city": city.id
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SigninResponse.fromJson(response.data);
      } else {
        return SigninResponse.fromError("Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Error Occurred. Please try again.");
    }
  }

  Future<SigninResponse> updateFamilyDetails(
      FatherOccupation fatherOccupation,
      MotherOccupation motherOccupation,
      int noOfBrothers,
      int noOfSister,
      int brotherMarried,
      int sistersMarried,
      String id) async {
    try {
      Response response = await this
          .dio
          .post(AppConstants.ENDPOINT + "users/familyDetail", data: {
        "fatherOccupation": fatherOccupation.index,
        "motherOccupation": motherOccupation.index,
        "numberOfBrothers": noOfBrothers,
        "marriedNumberOfBrothers": brotherMarried,
        "numberOfSisters": noOfSister,
        "marriedNumberOfSisters": sistersMarried,
        "userBasicId": id
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SigninResponse.fromJson(response.data);
      } else {
        return SigninResponse.fromError("Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Error Occurred. Please try again.");
    }
  }

  Future<PreSignUrlResponse> getPreSignedUrl(
      String imageName, String id) async {
    try {
      Response response = await this.dio.get(
          "${AppConstants.ENDPOINT}users/presignedUrl/${id}",
          queryParameters: {"fileKey": imageName, "contentType": "jpg"});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return PreSignUrlResponse.fromJson(response.data);
      } else {
        return PreSignUrlResponse.fromError(
            "Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return PreSignUrlResponse.fromError("Error Occurred. Please try again.");
    }
  }

  Future<Response> uploadFile(String url, String name, String path) async {
    Dio dio = Dio();
    // dio.interceptors.add(dioLoggerInterceptor);
    // dio.interceptors.add(InterceptorsWrapper(
    //     onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    //   options.headers["Content-Type"] = "image/jpg";
    //   options.receiveTimeout = 1000 * 30;
    //   options.onReceiveProgress = (val1, val2) {
    //     print("${val1} ---- ${val2}");
    //   };
    // },));
    FormData formData = FormData.fromMap({
      "name": await MultipartFile.fromFile(path, filename: name),
    });

    var result = await dio.put(url, data: formData);
    print(result.statusCode);
    return result;
  }
}
