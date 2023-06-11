import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makemymarry/datamodels/agora_token_response.dart';
import 'package:makemymarry/datamodels/blocked_users_response.dart';
import 'package:makemymarry/datamodels/connect.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/matching_percentage_response.dart';
import 'package:makemymarry/datamodels/recharge.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/socket_io/StreamSocket.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../datamodels/notification_response.dart';
import '../views/meet/bloc/meet_form_bloc.dart';

class ApiClient {
  final Dio dio = Dio();
  late StreamSocket streamSocket;
  ApiClient() {
    dio.interceptors.add(dioLoggerInterceptor);
    streamSocket = StreamSocket();
  }

  Future<RegistrationResponse> registerUser(
    int? profileCreatedFor,
    String email,
    String phoneCode,
    String mobile,
    Gender? gender,
    String password,
  ) async {
    try {
      var fcmToken = await FirebaseMessaging.instance.getToken();
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/basic", data: {
        "email": email,
        "gender": gender!.index,
        "countryCode": phoneCode,
        'fireBaseToken': fcmToken,
        "phoneNumber": mobile,
        "password": password,
        "relationship": profileCreatedFor
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegistrationResponse.fromJson(response.data);
      } else {
        return RegistrationResponse.fromError(
            "Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return RegistrationResponse.fromError(
          "Error Occurred. Please try again.");
    }
  }

  Future<SigninResponse> signinUser(String email, String password) async {
    try {
      var fcmToken = await FirebaseMessaging.instance.getToken();
      Response response = await this
          .dio
          .post(AppConstants.ENDPOINT + "auth/login", data: {
        "email": email,
        "password": password,
        'fireBaseToken': fcmToken
      });
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

  Future<AgoraTokenResponse> generateAgoraToken(
      {required String calleUserId,
      required String callerUserId,
      required CallType type}) async {
    try {
      Response response = await this
          .dio
          .post(AppConstants.ENDPOINT + "auth/generateAGoraToken", data: {
        "receiverId": calleUserId,
        "senderId": callerUserId,
        "callType": type.label
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AgoraTokenResponse.fromJson(response.data);
      } else {
        print('error1');
        return AgoraTokenResponse.fromError(
            "Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print('error2');
        return AgoraTokenResponse.fromError(error.response!.data["message"]);
      }
      print(error);
      return AgoraTokenResponse.fromError("Error Occurred. Please try again.");
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
    String userId,
  ) async {
    try {
      int heightCm = (heightStatus ?? 48);
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/about", data: {
        "userBasicId": userId,
        "name": name,
        "dateOfBirth": dob,
        "maritalStatus": maritalStatus!.index,
        "childrenStatus": childrenStatus!.index,
        "abilityStatus": abilityStatus!.index,
        "height": heightCm,
        "numberOfChildren": noOfChildren == null ? null : noOfChildren.index
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

  Future<MasterDataResponse> getMasterData(String? userId) async {
    try {
      Response response = await this.dio.get(
          AppConstants.ENDPOINT + "masters/profile-raw-data",
          queryParameters: userId != null ? {"userBasicId": userId} : {},
          options: Options(receiveTimeout: 0));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return MasterDataResponse.fromJson(response.data);
      } else {
        return MasterDataResponse.fromError(
            "Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {}
      return MasterDataResponse.fromError("Error Occurred. Please try again.");
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
        return SigninResponse.fromError("Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Error Occurred. Please try again.");
    }
  }

  Future<SigninResponse> verifyOtp(
      String dialCode, String mobile, OtpType otpType, String otp) async {
    try {
      var fcmToken = await FirebaseMessaging.instance.getToken();
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "auth/verifyOtp", data: {
        "countryCode": "+$dialCode",
        "phoneNumber": mobile,
        "type": otpType.index,
        'fireBaseToken': fcmToken,
        "email": "",
        "otp": otp
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SigninResponse.fromJson(response.data, otpType: otpType);
      } else {
        return SigninResponse.fromError("Please enter valid otp.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Please enter valid otp.");
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
        return SigninResponse.fromError("Please enter valid otp.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Please enter valid otp.");
    }
  }

  Future<SendOtpResponse> sendOtp(
      String dialCode, String mobile, OtpType login, String email) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "auth/sendOtp", data: {
        "countryCode": "+$dialCode",
        "phoneNumber": mobile,
        "type": login.index,
        "email": email,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SendOtpResponse.fromJson(response.data);
      } else {
        return SendOtpResponse.fromError("Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
        return SendOtpResponse.fromError(error.response!.data["message"]);
      }
      return SendOtpResponse.fromError("Error Occurred. Please try again.");
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
            "Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
        return CheckEmailResponse.fromError(error.response!.data["message"]);
      }
      return CheckEmailResponse.fromError("Error Occurred. Please try again.");
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
        return SendOtpResponse.fromError("Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SendOtpResponse.fromError("Error Occurred. Please try again.");
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
        return SigninResponse.fromError("Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Error Occurred. Please try againa.");
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

  Future<SigninResponse> updateLifeStyle(
    String uid,
    List<String> lifeStyles,
  ) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/lifestyle", data: {
        "userBasicId": uid,
        "lifestyle": lifeStyles.join(", "),
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

  Future<SigninResponse> updateHobby(
    String uid,
    List<String> hobbies,
  ) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/hobbies", data: {
        "userBasicId": uid,
        "hobbies": hobbies.join(", "),
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

  Future<DocumentUploadResponse> updateDoc(
      IdProofType idProof, List<String> images, String id) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/docs", data: {
        "userBasicId": id,
        "idProof": idProof.toString(),
        "userDocImages": images
            .map((e) => {
                  "imageUrl": e,
                  "isDefault": images.indexOf(e) == 0 ? true : false
                })
            .toList()
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return DocumentUploadResponse.fromJson(response.data);
      } else {
        return DocumentUploadResponse.fromError(
            "Error Occurred. Please try again.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return DocumentUploadResponse.fromError(
          "Error Occurred. Please try again.");
    }
  }

  Future<SigninResponse> careerVerification(
      // String nameOfOrg,
      String? occupation,
      AnnualIncome income,
      String? education,
      CountryModel country,
      StateModel stateName,
      StateModel city,
      String id) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/career", data: {
        "userBasicId": id,
        "employedIn": 'Hello',
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
        return SigninResponse.fromError("Error Occurred. Please try againaa.");
      }
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return SigninResponse.fromError("Error Occurred. Please try again.");
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
      return CountryResponse.fromError("Error Occurred. Please try again.");
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return CountryResponse.fromError("Error Occurred. Please try again.");
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
      return StateCityResponse.fromError("Error Occurred. Please try again.");
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return StateCityResponse.fromError("Error Occurred. Please try again.");
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
      return StateCityResponse.fromError("Error Occurred. Please try again.");
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return StateCityResponse.fromError("Error Occurred. Please try again.");
    }
  }

  Future<SigninResponse> updateFamilyBackground(
    FamilyAfluenceLevel familyAfluenceLevel,
    FamilyValues familyValues,
    FamilyType type,
    CountryModel countryModel,
    StateModel state,
    StateModel city,
    String id,
    bool isResidingWithFamily,
  ) async {
    try {
      Response response = await this
          .dio
          .post(AppConstants.ENDPOINT + "users/familyBackground", data: {
        "userBasicId": id,
        "familyStatus": familyAfluenceLevel.index,
        "familyValues": familyValues.index,
        "isResidingWithFamily": isResidingWithFamily,
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
    } catch (error, stacktrace) {
      if (error is DioError) {
        print(error.message);
      }
      return MatchingProfileResponse.fromError(
          "Error Occurred. Please try again.");
    }
  }

  Future<PremiumMembersResponse> getPremiumMembers(String id) async {
    try {
      var response = await this
          .dio
          .get("${AppConstants.ENDPOINT}users/premium_members/$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("omg${response.data}");
        var data = PremiumMembersResponse.fromJson(response.data);

        return data;
      }
      return PremiumMembersResponse.fromError(
          "Error Occurred. Please try again.");
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return PremiumMembersResponse.fromError(
          "Error Occurred. Please try again.");
    }
  }

  Future<RecentViewsResponse> getRecentViews(String id) async {
    try {
      var response =
          await this.dio.get("${AppConstants.ENDPOINT}users/recent_view/$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return RecentViewsResponse.fromJson(response.data);
      }
      return RecentViewsResponse.fromError("Error Occurred. Please try again.");
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return RecentViewsResponse.fromError("Error Occurred. Please try again.");
    }
  }

  Future<MeetListResponse> fetchAllMeets(String id) async {
    try {
      var response = await this.dio.get("${AppConstants.ENDPOINT}meet/get/$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return MeetListResponse.fromJson(response.data);
      }
      return MeetListResponse.fromError("Error Occurred. Please try again.");
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return MeetListResponse.fromError("Error Occurred. Please try again.");
    }
  }

  Future<ProfileVisitedResponse> getProfileVisitor(String id) async {
    try {
      var response = await this
          .dio
          .get("${AppConstants.ENDPOINT}users/profile_visited_by/$id");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProfileVisitedResponse.fromJson(response.data);
      }
      return ProfileVisitedResponse.fromError(
          "Error Occurred. Please try again.");
    } catch (error) {
      if (error is DioError) {
        print(error.message);
      }
      return ProfileVisitedResponse.fromError(
          "Error Occurred. Please try again.");
    }
  }

  final _socketResponse = StreamController<String>();
  void Function(String) get addResponse => _socketResponse.sink.add;
  Stream<String> get getResponse => _socketResponse.stream;
  void dispose() {
    _socketResponse.close();
  }

  void connectAndListen(id) {
    IO.Socket socket = IO.io('http://13.233.130.85:3000',
        OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {
      print('connect');
      socket.emit('onlineUsers', "fd1d372e-580d-42d9-8019-2cc658e839d1");
    });

    //When an event recieved from server, data is added to the stream
    socket.on('online_users_list', (data) {
      print("data$data");
      streamSocket.addResponse(data);
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  Future<MatchingProfileResponse> getOnlineMembers(
      String id, List<String> onlineUserIds) async {
    try {
      var response = await this
          .dio
          .post("${AppConstants.ENDPOINT}users/online_members/$id", data: {
        "onlineUserIds": onlineUserIds
        // "onlineUserIds": [
        //   "0ac85e91-1d8d-4950-b999-705199c8083d",
        //   "11b4c803-ca76-4695-ad88-ca116109bc72",
        //   "1498aaca-6e8f-4ccd-b4d1-110c9520896d",
        //   "1636e93d-cd8a-488c-9803-2ba454c06150",
        //   "5422df45-0156-40dd-8db6-24c589e8b140",
        //   "fddc858b-7b89-4a52-aea4-00c33fd552c6",
        //   "e992e797-e93c-44d6-9c10-ade71c901308",
        //   "e4711932-9497-4d5c-82d0-4026e9a9bb14",
        //   "e2a06a9f-83e5-4c2c-986c-804b996fe2cd",
        //   "d66ced90-3050-4d25-9892-46f43dd03c4e"
        // ]
      });
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

  Future<ProfileDetailsResponse> getOtherUserDetails(
      String id, ProfileActivationStatus activationStatus,
      {String? userId}) async {
    var response = await this.dio.post(
        "${AppConstants.ENDPOINT}users/basic/$id",
        data: userId == null ? null : {"myBasicId": userId});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ProfileDetailsResponse.fromJson(response.data, activationStatus);
    }
    return ProfileDetailsResponse.fromError(
        "Error Occurred. Please try again.");
  }

  Future<NotificationResponse> getNotifications(String id) async {
    var response = await this.dio.get(
          "${AppConstants.ENDPOINT}connects/user_notifications/$id",
        );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return NotificationResponse.fromJson(response.data);
    }
    return NotificationResponse.fromError("Error Occurred. Please try again.");
  }

  Future<BlockedUsersResponse> getBlockedUsers(String id) async {
    var response = await this.dio.get(
          "${AppConstants.ENDPOINT}users/blocked_users/$id",
        );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return BlockedUsersResponse.fromJson(response.data);
    }
    return BlockedUsersResponse.fromError("Error Occurred. Please try again.");
  }

  Future<PartnerPreferenceResponse> getPartnerPreference(
      {required String userId}) async {
    var response =
        await this.dio.get("${AppConstants.ENDPOINT}users/preference/$userId");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PartnerPreferenceResponse.fromJson(response.data);
    }
    return PartnerPreferenceResponse.fromError(
        "Error Occurred. Please try again.");
  }

  Future<ProfileDetailsResponse> getOtherUserDetailsByDisplayId(
      String displayId,
      ProfileActivationStatus activationStatus,
      String? userId) async {
    // try {
    var response = await this.dio.post(
        "${AppConstants.ENDPOINT}users/displaybasic/$displayId",
        data: userId == null ? null : {"myBasicId": userId});

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

  Future<String?> uploadDocImage(String id, String images) async {
    print("Akash Doc  uplaod");
    try {
      var length = await File(images).length();
      var file = MultipartFile(File(images).openRead(), length);
      var resposne = await this.dio.post(
          AppConstants.ENDPOINT + "users/docsImages/$id",
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
      List<AnnualIncome> annualIncome,
      List<AnnualIncome> annualIncomeMax,
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
        "minHeight": minHeight,
        "maxHeight": maxHeight,
        "maritalStatus": maritalStatus.map((e) => e.index).toList(),
        "country": [countryModel.id],
        "state": myState.map((e) => e!.id).toList(),
        "city": city.map((e) => e!.id).toList(),
        "religion": religion.map((e) => e.id).toList(),
        "caste": subCaste,
        "motherTongue": motherTongue.map((e) => e.id).toList(),
        "highestEducation": education.map((e) => e.id).toList(),
        "occupation": occupation.map((e) => e!).toList(),
        "maxIncome": annualIncomeMax.map((e) => e.index).toList(),
        "minIncome": annualIncome.map((e) => e.index).toList(),
        "dietaryHabits": eatingHabit.map((e) => e.index).toList(),
        "drinkingHabits": drinkingHabit.map((e) => e.index).toList(),
        "smokingHabits": smokingHabit.map((e) => e.index).toList(),
        "challenged": abilityStatus.index,
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

  Future<CreateMeetResponse> createMeetRequest(
      {required DateTime scheduleTime,
      required MeetType meetType,
      required String otherUserId,
      required LatLng latLng,
      required String location,
      required String id}) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "meet/create", data: {
        "requestingId": id,
        "requestedId": otherUserId,
        "link": meetType == MeetType.virtual ? "dummy Link" : "",
        "scheduleTime": scheduleTime.toIso8601String(),
        "address": location,
        'status': 0,
        "lat": latLng.latitude.toStringAsFixed(4),
        "long": latLng.longitude.toStringAsFixed(4),
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreateMeetResponse.fromJson(response.data);
      } else {
        return CreateMeetResponse.fromError("Please Try Again");
      }
    } catch (error) {
      return CreateMeetResponse.fromError("Please Try Again");
    }
  }

  Future<CreateMeetResponse> updateMeetRequest({
    required DateTime scheduleTime,
    required Activeconnection meet,
    required LatLng latLng,
    required String location,
  }) async {
    try {
      Response response = await this
          .dio
          .post(AppConstants.ENDPOINT + "meet/update/${meet.id}", data: {
        "requestingId": meet.requestingId,
        "requestedId": meet.requestedId,
        "link": meet.link,
        "scheduleTime": scheduleTime.toIso8601String(),
        "address": location,
        'status': meet.status,
        "lat": latLng.latitude.toStringAsFixed(4),
        "long": latLng.longitude.toStringAsFixed(4),
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreateMeetResponse.fromJson(response.data);
      } else {
        return CreateMeetResponse.fromError("Please Try Again");
      }
    } catch (error) {
      return CreateMeetResponse.fromError("Please Try Again");
    }
  }

  Future<CreateMeetResponse> updateMeetStatus(
      {required Activeconnection meet,
      required int status,
      required String id}) async {
    try {
      Response response = await this
          .dio
          .post(AppConstants.ENDPOINT + "meet/update/${meet.id}", data: {
        "requestingId": meet.requestingId,
        "requestedId": meet.requestedId,
        "link": meet.link,
        "scheduleTime": meet.scheduleTime.toIso8601String(),
        "address": meet.address,
        'status': status,
        "lat": meet.lat,
        "long": meet.long,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreateMeetResponse.fromJson(response.data);
      } else {
        return CreateMeetResponse.fromError("Please Try Again");
      }
    } catch (error) {
      return CreateMeetResponse.fromError("Please Try Again");
    }
  }

  Future<SettingsDataResponse> updateSettings({
    required bool showEmail,
    required bool showPhone,
    required bool isHidden,
    required bool isNotification,
    required String userId,
  }) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "settings/update/$userId", data: {
        "showEmail": showEmail,
        "showPhone": showPhone,
        "isHidden": isHidden ,
        "isNotification":isNotification,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SettingsDataResponse.fromJson(response.data);
      } else {
        return SettingsDataResponse.fromError("Please Try Again");
      }
    } catch (error) {
      return SettingsDataResponse.fromError("Please Try Again");
    }
  }


  Future<SettingsDataResponse> getSettingsData({
    required String userId,
  }) async {
    try {
      Response response =
      await this.dio.get(AppConstants.ENDPOINT + "settings/get/$userId");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return SettingsDataResponse.fromJson(response.data);
      } else {
        return SettingsDataResponse.fromError("Please Try Again");
      }
    } catch (error) {
      return SettingsDataResponse.fromError("Please Try Again");
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
      CountryModel countryModel,
      List<StateModel?> myState,
      List<StateModel?> city,
      List<SimpleMasterData> religion,
      List<dynamic> subCaste,
      List<SimpleMasterData> motherTongue,
      List<String?> occupation,
      List<Education> education,
      List<AnnualIncome> annualIncome,
      List<AnnualIncome> annualIncomeMax,
      List<EatingHabit> eatingHabit,
      List<DrinkingHabit> drinkingHabit,
      List<SmokingHabit> smokingHabit,
      AbilityStatus abilityStatus,
      String id) async {
    try {
      Response response = await this.dio.request(
          AppConstants.ENDPOINT + "users/filter-profiles/$id",
          options: Options(method: "GET"),
          data: {
            "userBasicId": id,
            "minAge": minAge,
            "maxAge": maxAge,
            "minHeight": minHeight,
            "maxHeight": maxHeight,
            "maritalStatus": maritalStatus.map((e) => e.index).toList(),
            "country": [countryModel.id],
            "state": myState.map((e) => e!.id).toList(),
            "city": city.map((e) => e!.id).toList(),
            "religion": religion.map((e) => e.id).toList(),
            "caste": subCaste,
            "motherTongue": motherTongue.map((e) => e.id).toList(),
            "highestEducation": education.map((e) => e.id).toList(),
            "occupation": occupation.map((e) => e!).toList(),
            "maxIncome": annualIncomeMax.map((e) => e.index).toList(),
            "minIncome": annualIncome.map((e) => e.index).toList(),
            "dietaryHabits": eatingHabit.map((e) => e.index).toList(),
            "drinkingHabits": drinkingHabit.map((e) => e.index).toList(),
            "smokingHabits": smokingHabit.map((e) => e.index).toList(),
            "challenged": abilityStatus.index,
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        return MatchingProfileResponse.fromJson(response.data);
      } else {
        return MatchingProfileResponse.fromError(
            "Please Try Again, didn't find any relevant profiles.");
      }
    } catch (error) {
      return MatchingProfileResponse.fromError(
          "Please Try Again, didn't find any relevant profiles.");
    }
  }

  Future<LikeStatusResponse> setLikeStatus(
      String likedUserId, String likedByUserId, String? requestId) async {
    try {
      var response = await this
          .dio
          .post(AppConstants.ENDPOINT + 'connects/user_request', data: {
        "requestingUserBasicId": likedByUserId,
        "requestedUserBasicId": likedUserId,
        "userRequestId": requestId ?? "",
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

  Future blockProfile(String blockBy, blockTo) {
    return this.dio.get(
          AppConstants.ENDPOINT + "users/block_user/$blockBy/$blockTo",
        );
  }

  Future unblockProfile(
    String blockId,
  ) {
    return this.dio.delete(
          AppConstants.ENDPOINT + "users/unblock_user/$blockId",
        );
  }

  Future<ConnectHistoryResponse> getConnectHistory(String id) async {
    try {
      var response = await this.dio.get(
            AppConstants.ENDPOINT + 'connects/connect_transaction/$id',
          );
      return ConnectHistoryResponse.fromJson(response.data);
    } catch (error) {
      return ConnectHistoryResponse.fromError("Something went wrong");
    }
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
