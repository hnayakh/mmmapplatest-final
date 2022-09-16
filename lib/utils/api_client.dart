import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:makemymarry/datamodels/connect.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/matching_percentage_response.dart';
import 'package:makemymarry/datamodels/recharge.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile.dart';

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
        print('error1');
        return SigninResponse.fromError("Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print('error2');
        return SigninResponse.fromError(error.response!.data["message"]);
      }
      print(error);
      return SigninResponse.fromError("Error Occurred. Please try again.");
    }
  }

  Future<void> signoutuser() async {
    return null;
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
      double heightCm =
          double.parse(AppHelper.getHeights()[heightStatus!].split(".")[0]) *
                  30.48 +
              double.parse(AppHelper.getHeights()[heightStatus].split(".")[1]) *
                  2.54;

      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/about", data: {
        "userBasicId": userId,
        "name": name,
        "dateOfBirth": dob,
        "maritalStatus": maritalStatus!.index,
        "childrenStatus": childrenStatus!.index,
        "abilityStatus": abilityStatus!.index,
        "height": double.parse(AppHelper.getHeights()[heightStatus]) * 30.48,
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
          queryParameters: userId != null ? {"userBasicId": userId} : {},
          options: Options(receiveTimeout: 0));
      print('response.statusCode');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return MasterDataResponse.fromJson(response.data);
      } else {
        return MasterDataResponse.fromError(
            "Error Occurred. Please try againa.");
      }
    } catch (error) {
      if (error is DioError) {
        print('error is');
        print(error.message);
      }
      return MasterDataResponse.fromError("Error Occurred. Please try againa.");
    }
  }

  //
  // Future<ProfileDataResponse> getAllUsersProfileData(String userId) async {
  //   try {
  //     Response response = await this.dio.get(
  //           AppConstants.ENDPOINT + "users/profiles/$userId",
  //         );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return ProfileDataResponse.fromJson(response.data, userId);
  //     } else {
  //       return ProfileDataResponse.fromError(
  //           "Error Occurred. Please try again.");
  //     }
  //   } catch (error) {
  //     if (error is DioError) {
  //       print(error.message);
  //     }
  //     print('the error is..');
  //     print(error);
  //     return ProfileDataResponse.fromError("Error Occurred. Please try again.");
  //   }
  // }

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
        return SendOtpResponse.fromError(error.response!.data["message"]);
      }
      return SendOtpResponse.fromError("Error Occurred. Please try againa.");
    }
  }

  Future<CheckEmailResponse> checkEmail(String email) async {
    try {
      Response response = await this
          .dio
          .get(AppConstants.ENDPOINT + "users/validate/email?email=$email");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CheckEmailResponse.fromJson(response.data);
      } else {
        return CheckEmailResponse.fromError(
            "Error Occurred. Please try againa.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
        return CheckEmailResponse.fromError(error.response!.data["message"]);
      }
      return CheckEmailResponse.fromError("Error Occurred. Please try againa.");
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

  Future<SigninResponse> updateBio(
      String aboutMe, List<String> images, String id) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/bio", data: {
        "userBasicId": id,
        "aboutMe": aboutMe,
        "userImages": images
            .map((e) => {
                  "imageUrl": e,
                  "isDefault": images.indexOf(e) == 0 ? true : false
                })
            .toList()
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

  Future<SigninResponse> careerVerification(
      // String nameOfOrg,
      String? occupation,
      AnualIncome income,
      String? education,
      CountryModel country,
      StateModel stateName,
      StateModel city,
      String id) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/career", data: {
        "userBasicId": id,
        "employedIn": 'Bypassedasperclient',
        "occupation": occupation,
        "annualIncome": income.index,
        "highestEducation": education,
        "country": country.id,
        "state": stateName.id,
        "city": city.id
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SigninResponse.fromJson(response.data);
      } else {
        return SigninResponse.fromError("Error Occurred. Please try againaaa.");
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

  Future<Response?> uploadFile(String url, String name, String path) async {
    try {
      Dio dio = Dio();
      dio.interceptors.add(dioLoggerInterceptor);
      // dio.interceptors.add(dioLoggerInterceptor);
      // dio.interceptors.add(InterceptorsWrapper(
      //     onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      //   options.headers["Content-Type"] = "image/jpg";
      //   options.receiveTimeout = 1000 * 30;
      //   options.onReceiveProgress = (val1, val2) {
      //     print("${val1} ---- ${val2}");
      //   };
      // },));
      Uint8List image = File(path).readAsBytesSync();
      MultipartFile file = MultipartFile(File(path).openRead(), image.length);
      var result = await dio.put(url,
          data: FormData.fromMap({"file": file}),
          options: Options(headers: {
            'Transfer-Encoding': 'chunked',
            'Accept-Encoding': 'gzip, deflate, br'
          }, receiveTimeout: 5 * 50 * 1000, sendTimeout: 5 * 60 * 1000));
      print(result);
      return result;
    } catch (error) {
      print(error);
      if (error is DioError) {
        print(error.message);
      }
      return null;
    }
  }

  Future<MatchingProfileResponse> getMyMatchingProfile(String id) async {
    try {
      var response =
          await this.dio.get("${AppConstants.ENDPOINT}users/profiles/$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("omg${response.data}");
        var data = MatchingProfileResponse.fromJson(response.data);

        return data;
      }
      return MatchingProfileResponse.fromError(
          "Error Occurred. Please try again.");
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return MatchingProfileResponse.fromError(
          "Error Occurred. Please try again.");
    }
  }

  Future<MatchingProfileResponse> getRecentViews(String id) async {
    try {
      var response = await this
          .dio
          .get("${AppConstants.ENDPOINT}users/profile_visited_by/$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return MatchingProfileResponse.fromJson(response.data);
      }
      return MatchingProfileResponse.fromError(
          "Error Occurred. Please try again.");
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return MatchingProfileResponse.fromError(
          "Error Occurred. Please try again.");
    }
  }

  Future<MatchingProfileResponse> getProfileVisitor(String id) async {
    // try {
    var response =
        await this.dio.get("${AppConstants.ENDPOINT}users/recent_view/$id");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return MatchingProfileResponse.fromJson(response.data);
    }
    return MatchingProfileResponse.fromError(
        "Error Occurred. Please try again.");
    // }
    // catch (error) {
    //   if (error is DioError) {
    //     print(error.message);
    //   }
    //   return MatchingProfileResponse.fromError(
    //       "Error Occurred. Please try again.");
    // }
  }

  Future<ProfileDetailsResponse> getOtherUserDetails(
      String id, ProfileActivationStatus activationStatus) async {
    // try {
    var response =
        await this.dio.get("${AppConstants.ENDPOINT}users/basic/$id");

    print("sresponse${response.data['data']}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ProfileDetailsResponse.fromJson(response.data, activationStatus);
    }
    return ProfileDetailsResponse.fromError(
        "Error Occurred. Please try again.");
    // } catch (error) {
    //   if (error is DioError) {
    //     print(error.message);
    //   }
    //   return ProfileDetailsResponse.fromError(
    //       "Error Occurred. Please try again.");
    // }
  }

  Future<String?> uploadImage(String id, String images) async {
    print("saurabh uplaod");
    try {
      var length = await File(images).length();
      var file = MultipartFile(File(images).openRead(), length);
      var resposne = await this.dio.post(
          AppConstants.ENDPOINT + "users/images/$id",
          data: FormData.fromMap(
              {"files": await MultipartFile.fromFile(images)}));
      print(resposne.data);
      if (resposne.statusCode == 200 || resposne.statusCode == 201) {
        if (resposne.data["data"].length > 0) {
          return resposne.data["data"][0];
        }
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return null;
    }
  }

  Future<SimpleResponse> completePreference(
      double maxHeight,
      double minHeight,
      double maxAge,
      double minAge,
      List<MaritalStatus> maritalStatus,
      CountryModel countryModel,
      List<StateModel?> myState,
      List<StateModel?> city,
      List<SimpleMasterData> religion,
      List<dynamic> subCaste,
      List<SimpleMasterData> motherTongue,
      List<String?> occupation,
      List<Education> education,
      List<AnualIncome> annualIncome,
      List<EatingHabit> eatingHabit,
      List<DrinkingHabit> drinkingHabit,
      List<SmokingHabit> smokingHabit,
      AbilityStatus abilityStatus,
      String id) async {
    try {
      Response response = await this
          .dio
          .post(AppConstants.ENDPOINT + "users/preference", data: {
        "userBasicId": id,
        "minAge": minAge,
        "maxAge": maxAge,
        "minHeight": minHeight * 30.48,
        "maxHeight": maxHeight * 30.48,
        "maritalStatus": maritalStatus.map((e) => e.index).toList(),
        "country": [countryModel.id],
        "state": myState.map((e) => e!.id).toList(),
        "city": city.map((e) => e!.id).toList(),
        "religion": religion.map((e) => e.id).toList(),
        "caste": subCaste,
        "motherTongue": motherTongue.map((e) => e.id).toList(),
        "highestEducation": education.map((e) => e.id).toList(),
        "occupation": occupation.map((e) => e!).toList(),
        "maxIncome": annualIncome.map((e) => e.index).toList(),
        "minIncome": annualIncome.map((e) => e.index).toList(),
        "dietaryHabits": annualIncome.map((e) => e.index).toList(),
        "drinkingHabits": annualIncome.map((e) => e.index).toList(),
        "smokingHabits": annualIncome.map((e) => e.index).toList(),
        "challenged": abilityStatus.index
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SimpleResponse.fromJson(response.data);
      } else {
        return SimpleResponse.fromError("Please Try Again");
      }
    } catch (error) {
      return SimpleResponse.fromError("Please Try Again");
    }
  }

  Future updateRegistartionStep(basicuserId, step) {
    return this.dio.post(AppConstants.ENDPOINT +
        "users/app/users/updateRegistrationStep/$basicuserId/$step");
  }

  Future<MatchingProfileResponse> completeFilter(
      double maxHeight,
      double minHeight,
      double maxAge,
      double minAge,
      List<MaritalStatus> maritalStatus,
      List<CountryModel> countryModel,
      List<StateModel?> myState,
      List<StateModel?> city,
      List<SimpleMasterData> religion,
      List<dynamic> subCaste,
      List<SimpleMasterData> motherTongue,
      List<String?> occupation,
      List<Education> education,
      List<AnualIncome> annualIncome,
      List<EatingHabit> eatingHabit,
      List<DrinkingHabit> drinkingHabit,
      List<SmokingHabit> smokingHabit,
      AbilityStatus abilityStatus,
      String id) async {
    try {
      Response response = await this
          .dio
          .post(AppConstants.ENDPOINT + "users/app/users/filter", data: {
        "userBasicId": id,
        "minAge": minAge,
        "maxAge": maxAge,
        "minHeight": minHeight * 30.48,
        "maxHeight": maxHeight * 30.48,
        "maritalStatus": maritalStatus.map((e) => e.index).toList(),
        "country": countryModel.map((e) => e.id).toList(),
        "state": myState.map((e) => e!.id).toList(),
        "city": city.map((e) => e!.id).toList(),
        "religion": religion.map((e) => e.id).toList(),
        "caste": subCaste,
        "motherTongue": motherTongue.map((e) => e.id).toList(),
        "highestEducation": education.map((e) => e.id).toList(),
        "occupation": occupation.map((e) => e!).toList(),
        "maxIncome": annualIncome.map((e) => e.index).toList(),
        "minIncome": annualIncome.map((e) => e.index).toList(),
        "dietaryHabits": annualIncome.map((e) => e.index).toList(),
        "drinkingHabits": annualIncome.map((e) => e.index).toList(),
        "smokingHabits": annualIncome.map((e) => e.index).toList(),
        "challenged": abilityStatus.index
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return MatchingProfileResponse.fromJson(response.data);
      } else {
        return MatchingProfileResponse.fromError("Please Try Again");
      }
    } catch (error) {
      return MatchingProfileResponse.fromError("Please Try Again");
    }
  }

  Future<LikeStatusResponse> setLikeStatus(
      String likedUserId, String likedByUserId) async {
    print('set like');
    print(likedByUserId);
    print(likedUserId);
    try {
      var response = await this
          .dio
          .post(AppConstants.ENDPOINT + 'connects/user_request', data: {
        "requestingUserBasicId": likedByUserId,
        "requestedUserBasicId": likedUserId,
        "userRequestId": "",
        "operation": 0
      });
      return LikeStatusResponse.fromJson(response.data);
    } catch (error) {
      return LikeStatusResponse.fromError("Please Try Again");
    }
  }

  Future<InterestResponse> getInterestList(String id) async {
    try {
      var response = await this
          .dio
          .get(AppConstants.ENDPOINT + 'connects/user_request/$id');
      return InterestResponse.fromJson(response.data);
    } catch (error) {
      // return InterestResponse.fromError(error.toString());
      return InterestResponse.fromError("No Request Sent Yet");
    }
  }

  Future<LikeStatusResponse> cancelSentInterest(
      String currentUser, String otherUser, String requestId) async {
    try {
      var response = await this
          .dio
          .post(AppConstants.ENDPOINT + 'connects/user_request', data: {
        "requestingUserBasicId": currentUser,
        "requestedUserBasicId": otherUser,
        "userRequestId": requestId,
        "operation": 5
      });
      return LikeStatusResponse.fromJson(response.data);
    } catch (error) {
      return LikeStatusResponse.fromError(error.toString());
    }
  }

  Future<LikeStatusResponse> rejectReceivedInterest(
      String currentUser, String otherUser, String requestId) async {
    try {
      var response = await this
          .dio
          .post(AppConstants.ENDPOINT + 'connects/user_request', data: {
        "requestingUserBasicId": currentUser,
        "requestedUserBasicId": otherUser,
        "userRequestId": requestId,
        "operation": 2
      });
      return LikeStatusResponse.fromJson(response.data);
    } catch (error) {
      return LikeStatusResponse.fromError(error.toString());
    }
  }

  Future<LikeStatusResponse> acceptReceivedInterest(
      String currentUser, String otherUser, String requestId) async {
    try {
      var response = await this
          .dio
          .post(AppConstants.ENDPOINT + 'connects/user_request', data: {
        "requestingUserBasicId": otherUser,
        "requestedUserBasicId": currentUser,
        "userRequestId": requestId,
        "operation": 1
      });
      return LikeStatusResponse.fromJson(response.data);
    } catch (error) {
      return LikeStatusResponse.fromError(error.toString());
    }
  }

  Future<CouponDetailsResponse> validateCoupon(String coupon) async {
    try {
      var response =
          await this.dio.get(AppConstants.ENDPOINT + 'masters/coupons/$coupon');
      return CouponDetailsResponse.fromJson(response.data);
    } catch (error) {
      return CouponDetailsResponse.fromError("Something went wrong");
    }
  }

  Future<ConnectPriceDetailsResponse> getConnectPriceDetails() async {
    try {
      var response =
          await this.dio.get(AppConstants.ENDPOINT + 'masters/connects');
      return ConnectPriceDetailsResponse.fromJson(response.data);
    } catch (error) {
      return ConnectPriceDetailsResponse.fromError("Something went wrong");
    }
  }

  Future<SimpleResponse> recharge(RechargeModel rechargeModel) async {
    try {
      var response = await this.dio.post(
          AppConstants.ENDPOINT + 'connects/recharge',
          data: rechargeModel.data);
      return SimpleResponse.fromJson(response.data);
    } catch (error) {
      return SimpleResponse.fromError("Something went wrong");
    }
  }

  Future<CurrentBalanceResponse> fetchCurrentBalance(String id) async {
    try {
      var response = await this.dio.get(
            AppConstants.ENDPOINT + 'connects/user_connect/$id',
          );
      return CurrentBalanceResponse.fromJson(response.data);
    } catch (error) {
      return CurrentBalanceResponse.fromError("Something went wrong");
    }
  }

  Future<RechargeHistoryResponse> getTransactionHistory(String id) async {
    try {
      var response = await this.dio.get(
            AppConstants.ENDPOINT + 'connects/recharge/$id',
          );
      return RechargeHistoryResponse.fromJson(response.data);
    } catch (error) {
      return RechargeHistoryResponse.fromError("Something went wrong");
    }
  }

  Future<ConnectResponse> connectUsers(
      String connectById, String connectToId) async {
    try {
      var response = await this.dio.post(
          AppConstants.ENDPOINT + 'connects/user_connect_request',
          data: {"userOneBasicId": connectById, "userTwoBasicId": connectToId});
      return ConnectResponse.fromJson(response.data);
    } catch (error) {
      return ConnectResponse.fromError("Something went wrong");
    }
  }

  Future<MyConnectResponse> getMyConnects(String userId) async {
    try {
      var response = await this.dio.get(
            AppConstants.ENDPOINT + 'connects/user_allconnect/$userId',
          );
      return MyConnectResponse.fromJson(response.data);
    } catch (error) {
      return MyConnectResponse.fromError("Something went wrong");
    }
  }

  Future visitProfile(String id, String visitedBy) async {
    var reponse = await this.dio.post(
        AppConstants.ENDPOINT + "users/visit_profile",
        queryParameters: {"visitedBy": visitedBy, "visitedTo": id});
    print(reponse);
  }

  Future<ConnectHistoryResponse> getConnectHistory(String id) async {
    // try {
    var response = await this.dio.get(
          AppConstants.ENDPOINT + 'connects/connect_transaction/$id',
        );
    return ConnectHistoryResponse.fromJson(response.data);
    // } catch (error) {
    //   return ConnectHistoryResponse.fromError("Something went wrong");
    // }
  }

  Future<MySearchResponse> getConnectThroughMMId(
      String id, String displayId) async {
    try {
      var response = await this.dio.get(
            AppConstants.ENDPOINT + 'users/user_serach/$id?diplayId=$displayId',
          );
      print("object");
      print(response.data);
      return MySearchResponse.fromJson(response.data);
    } catch (error) {
      print("error");
      return MySearchResponse.fromError("Something went wrong");

      //return MySearchResponse.fromError(error.toString());
    }
  }

  Future<MatchingPercentageResponse> getMatchPercentage(
      String id, String otherBasicId) async {
    try {
      var response = await this.dio.get(
            AppConstants.ENDPOINT +
                'users/match_percentage/$id?otherUserBasicId=$otherBasicId',
          );
      print("object");
      print(response.data);
      return MatchingPercentageResponse.fromJson(response.data);
    } catch (error) {
      print("error");
      return MatchingPercentageResponse.fromError("Something went wrong");

      //return MySearchResponse.fromError(error.toString());
    }
  }
}
