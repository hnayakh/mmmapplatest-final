import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/profile_data.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/utils/api_client.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/storage_service.dart';
import 'package:makemymarry/views/profilescreens/religion/religion_bloc.dart';

class UserRepository {
  late StorageService storageService;
  ApiClient apiClient = ApiClient();

  UserDetails? useDetails;
  late MasterData masterData;
  late List<ProfileDetails> listProfileDetails;

  UserRepository() {
    this.storageService = StorageService();
  }

  Future<bool?> getHasOpenedBefore() async {
    return this.storageService.isFirstTimeLogin();
  }

  Future<UserDetails?> getUserDetails() async {
    return this.storageService.getUserDetails();
  }

  Future<RegistrationResponse> register(int? profileCreatedFor, String email,
      String phoneCode, String mobile, Gender? gender, String password) async {
    return this.apiClient.registerUser(
        profileCreatedFor, email, phoneCode, mobile, gender, password);
  }

  Future<SigninResponse> login(String email, String password) async {
    return this.apiClient.signinUser(email, password);
  }

  Future<SigninResponse> about(
      NoOfChildren? noOfChildren,
      MaritalStatus? maritalStatus,
      AbilityStatus? abilityStatus,
      ChildrenStatus? childrenStatus,
      int? heightStatus,
      String? dob,
      String? name) async {
    return this.apiClient.aboutVerification(
        noOfChildren,
        maritalStatus,
        abilityStatus,
        childrenStatus,
        heightStatus,
        dob,
        name,
        this.useDetails!.id);
  }

  Future<MasterDataResponse> getMasterData() async {
    return apiClient.getMasterData(null);
  }

  Future<ProfileDataResponse> getAllUsersProfileData() async {
    return apiClient.getAllUsersProfileData();
  }

  saveUserDetails() async {
    this.storageService.saveUserDetails(this.useDetails!);
  }

  Future<SigninResponse> verifyOtp(
      String dialCode, String mobile, OtpType otpType, String otp) async {
    return this.apiClient.verifyOtp(dialCode, mobile, otpType, otp);
  }

  Future<SendOtpResponse> sendOtp(String dialCode, String mobile, OtpType login,
      {String email = ""}) async {
    return this.apiClient.sendOtp(dialCode, mobile, login);
  }

  Future<SendOtpResponse> sendOtpEmail(String email) async {
    return this.apiClient.sendOtpEmail(email);
  }

  Future<SigninResponse> verifyOtpEmail(String email, String otp) async {
    return this.apiClient.verifyOtpEmail(email, otp);
  }

  Future<SigninResponse> habit(EatingHabit eatingHabit,
      SmokingHabit smokingHabit, DrinkingHabit drinkingHabit) async {
    return apiClient.habitVerification(
        eatingHabit, smokingHabit, drinkingHabit, useDetails!.id);
  }

  Future<SigninResponse> updateReligion(
      SimpleMasterData religion,
      dynamic subCaste,
      SimpleMasterData motherTongue,
      gothra,
      Manglik isManglik) async {
    return apiClient.updateReligion(
        religion, subCaste, motherTongue, gothra, isManglik, useDetails!.id);
  }

  Future<SigninResponse> updateBio(String aboutMe, String imageUrl1,
      String imageUrl2, String imageUrl3, String imageUrl4) async {
    return apiClient.updateBio(
        aboutMe, imageUrl1, imageUrl2, imageUrl3, imageUrl4, useDetails!.id);
  }

  Future<SigninResponse> career(
      String nameOfOrg,
      String? occupation,
      String income,
      String? education,
      CountryModel country,
      StateModel stateName,
      StateModel city) async {
    return apiClient.careerVerification(nameOfOrg, occupation, income,
        education, country, stateName, city, useDetails!.id);
  }

  Future<CountryResponse> getCountries() async {
    return apiClient.getCountryList();
  }

  Future<StateCityResponse> getStates(int id) async {
    return apiClient.getState(id);
  }

  Future<StateCityResponse> getCities(int id) async {
    return apiClient.getCity(id);
  }

  Future<SigninResponse> updateFamilyBackground(
      FamilyAfluenceLevel familyAfluenceLevel,
      FamilyValues familyValues,
      FamilyType type,
      CountryModel countryModel,
      StateModel state,
      StateModel city) async {
    return apiClient.updateFamilyBackground(familyAfluenceLevel, familyValues,
        type, countryModel, state, city, useDetails!.id);
  }

  Future<SigninResponse> updateFamilyDetails(
      FatherOccupation fatherOccupation,
      MotherOccupation motherOccupation,
      int noOfBrothers,
      int noOfSister,
      int brotherMarried,
      int sistersMarried) async {
    return apiClient.updateFamilyDetails(
        fatherOccupation,
        motherOccupation,
        noOfBrothers,
        noOfSister,
        brotherMarried,
        sistersMarried,
        useDetails!.id);
  }
}
