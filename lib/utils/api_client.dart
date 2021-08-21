import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';

class ApiClient {
  final Dio dio = Dio();

  ApiClient() {
    dio.interceptors.add(dioLoggerInterceptor);
  }

  Future<RegistrationResponse> registerUser(int profileCreatedFor, String email,
      String phoneCode, String mobile, Gender gender, String password) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/basic", data: {
        "email": email,
        "gender": gender.index,
        "countryCode": phoneCode,
        "phoneNumber": mobile,
        "password": password
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
      HeightStatus? heightStatus,
      String? dob,
      String? name) async {
    try {
      Response response =
          await this.dio.post(AppConstants.ENDPOINT + "users/about", data: {
        "userBasicId": "c6feebb2-f5db-4958-b719-1edfca0d603e",
        "name": name,
        "dateOfBirth": dob,
        "maritalStatus": maritalStatus,
        "childrenStatus": childrenStatus,
        "abilityStatus": abilityStatus,
        "height": heightStatus
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
}
