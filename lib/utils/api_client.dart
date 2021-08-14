import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
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
}
