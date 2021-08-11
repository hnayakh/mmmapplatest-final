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

  Future<String?> getUserDetails() async {
    await initPrefs();
    return this.sharedPreferences.getString(AppConstants.USERID);
  }
}
