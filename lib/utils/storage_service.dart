import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late SharedPreferences sharedPreferences;

  initPrefs() async {
    this.sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool?> isFirstTimeLogin() async {
    await initPrefs();
    return this.sharedPreferences.getBool(AppConstants.HASOPENEDBEFORE);
  }

  setFirstTimeOver() async {
    await initPrefs();
    await this.sharedPreferences.setBool(AppConstants.HASOPENEDBEFORE, true);
  }

  Future saveUserDetails(UserDetails userDetails) async {
    await initPrefs();
    this.sharedPreferences.setString(AppConstants.USERID, userDetails.id);
    this.sharedPreferences.setString(AppConstants.MOBILE, userDetails.mobile);
    this.sharedPreferences.setString(AppConstants.EMAIL, userDetails.email);
    this
        .sharedPreferences
        .setString(AppConstants.DIALCODE, userDetails.dialCode);
    this.sharedPreferences.setInt(AppConstants.GENDER, userDetails.gender);
    this
        .sharedPreferences
        .setInt(AppConstants.ACTIVATIONSTATUS, userDetails.activationStatus);
    this
        .sharedPreferences
        .setInt(AppConstants.LIFECYCLESTATUS, userDetails.lifecycleStatus);
    this
        .sharedPreferences
        .setInt(AppConstants.REGISTRATIONSTEP, userDetails.registrationStep);
    this.sharedPreferences.setBool(AppConstants.ISACTIVE, userDetails.isActive);
  }

  Future<UserDetails?> getUserDetails() async {
    await initPrefs();
    var id = this.sharedPreferences.getString(AppConstants.USERID);
    if (id == null) {
      return null;
    } else {
      var gender = this.sharedPreferences.getInt(AppConstants.GENDER);
      var isActive = this.sharedPreferences.getBool(AppConstants.ISACTIVE);
      var mobile = this.sharedPreferences.getString(AppConstants.MOBILE);
      var email = this.sharedPreferences.getString(AppConstants.EMAIL);
      var dialCode = this.sharedPreferences.getString(AppConstants.DIALCODE);
      var lifeCycleStep =
          this.sharedPreferences.getInt(AppConstants.LIFECYCLESTATUS);
      var activatonStateus =
          this.sharedPreferences.getInt(AppConstants.ACTIVATIONSTATUS);
      var registrationStep =
          this.sharedPreferences.getInt(AppConstants.REGISTRATIONSTEP);

      return UserDetails.fromStorage(id, mobile!, dialCode!, email!, gender!,
          isActive!, lifeCycleStep!, activatonStateus!, registrationStep!);
    }
  }
}
