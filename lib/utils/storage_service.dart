import 'dart:developer';

import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/utils/app_constants.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
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
    // print('UserDetail------');
    // print(userDetails.secretToken);
    await initPrefs();
    //ifelse all
    this.sharedPreferences.setString(AppConstants.USERID, userDetails.id);
    this
        .sharedPreferences
        .setString(AppConstants.DISPLAYID, userDetails.displayId);
    this
        .sharedPreferences
        .setString(AppConstants.DATEOFBIRTH, userDetails.dateOfBirth);
    this
        .sharedPreferences
        .setInt(AppConstants.RELATIONSHIP, userDetails.relationship.index);

    this.sharedPreferences.setDouble(AppConstants.HEIGHT, userDetails.height);
    this
        .sharedPreferences
        .setInt(AppConstants.MARITALSTATUS, userDetails.maritalStatus.index);
    this
        .sharedPreferences
        .setInt(AppConstants.ABILITYSTATUS, userDetails.abilityStatus.index);
    // this.sharedPreferences.setString(
    //     AppConstants.COUNTRYMODELNAME, userDetails.countryModel.name);
    // this.sharedPreferences.setString(
    //     AppConstants.COUNTRYMODELSHORTNAME, userDetails.countryModel.shortName);
    // this
    //     .sharedPreferences
    //     .setInt(AppConstants.COUNTRYMODELID, userDetails.countryModel.id);
    this
        .sharedPreferences
        .setString(AppConstants.RELIGIONID, userDetails.religion.id);
    this
        .sharedPreferences
        .setString(AppConstants.RELIGIONTITLE, userDetails.religion.title);
    this
        .sharedPreferences
        .setString(AppConstants.MOTHERTONGUEID, userDetails.motherTongue.id);
    this.sharedPreferences.setString(
        AppConstants.MOTHERTONGUETITLE, userDetails.motherTongue.title);
    this.sharedPreferences.setString(
        AppConstants.COUNTRYMODELNAME, userDetails.countryModel.name);
    this.sharedPreferences.setString(
        AppConstants.COUNTRYMODELSHORTNAME, userDetails.countryModel.shortName);
    this
        .sharedPreferences
        .setInt(AppConstants.COUNTRYMODELID, userDetails.countryModel.id);

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
    // this.sharedPreferences.setString('secretToken', userDetails.secretToken);
// To save the value, use this:
    //await storage.write(key: "my-secure-jwt", value: myJwt);

    //this.sharedPreferences.setString("jwt", userDetails.jwt);
  }

  Future<UserDetails?> getUserDetails() async {
    await initPrefs();
    var id = this.sharedPreferences.getString(AppConstants.USERID);
    if (id == null) {
      print('id is null');
      return null;
    } else {
      print('id not null');
      //var jwt = this.sharedPreferences.getString("jwt")!;

      var displayId = this.sharedPreferences.getString(AppConstants.DISPLAYID);
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
      var dateOfBirth =
          this.sharedPreferences.getString(AppConstants.DATEOFBIRTH);
      var relationship = Relationship
          .values[this.sharedPreferences.getInt(AppConstants.RELATIONSHIP)!];
      var height = this.sharedPreferences.getDouble(AppConstants.HEIGHT);
      var maritalStatus = MaritalStatus
          .values[this.sharedPreferences.getInt(AppConstants.MARITALSTATUS)!];
      var abilityStatus = AbilityStatus
          .values[this.sharedPreferences.getInt(AppConstants.ABILITYSTATUS)!];
      print('instorage');

      CountryModel countryModel = CountryModel();
      countryModel.id =
          this.sharedPreferences.getInt(AppConstants.COUNTRYMODELID)!;
      countryModel.name =
          this.sharedPreferences.getString(AppConstants.COUNTRYMODELNAME)!;
      countryModel.shortName =
          this.sharedPreferences.getString(AppConstants.COUNTRYMODELSHORTNAME)!;

      SimpleMasterData religion = SimpleMasterData();
      SimpleMasterData motherTongue = SimpleMasterData();
      religion.id = this.sharedPreferences.getString(AppConstants.RELIGIONID)!;
      religion.title =
          this.sharedPreferences.getString(AppConstants.RELIGIONTITLE)!;
      motherTongue.id =
          this.sharedPreferences.getString(AppConstants.MOTHERTONGUEID)!;
      motherTongue.title =
          this.sharedPreferences.getString(AppConstants.MOTHERTONGUETITLE)!;

      print(religion.id);
      print(motherTongue.id);

      return UserDetails.fromStorage(
        displayId!,
        id,
        // jwt,
        mobile!,
        dialCode!,
        email!,
        gender!,
        isActive!,
        lifeCycleStep!,
        activatonStateus!,
        registrationStep!,
        dateOfBirth!,
        relationship,
        height!,
        maritalStatus,
        abilityStatus,
        countryModel,
        religion,
        motherTongue,
      );
    }
  }

  updateRegistrationStep(int value) async {
    await initPrefs();
    var registrationStep =
        this.sharedPreferences.setInt(AppConstants.REGISTRATIONSTEP, value);
  }
}
