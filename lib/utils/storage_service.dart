import 'package:makemymarry/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  SharedPreferences sharedPreferences;

  initPrefs() async {
    this.sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> isFirstTimeLogin() async {
    initPrefs();
    return this.sharedPreferences.getBool(AppConstants.HASOPENEDBEFORE);
  }

  setFirstTimeOver() async {
    initPrefs();
    this.sharedPreferences.setBool(AppConstants.HASOPENEDBEFORE, true);
  }
}
