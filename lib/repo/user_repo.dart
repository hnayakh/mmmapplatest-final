import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/utils/api_client.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/storage_service.dart';

class UserRepository {
  late StorageService storageService;
  ApiClient apiClient = ApiClient();

  UserDetails? useDetails;
  MasterData? masterData;

  UserRepository() {
    this.storageService = StorageService();
  }

  Future<bool?> getHasOpenedBefore() async {
    return this.storageService.isFirstTimeLogin();
  }

  Future<UserDetails?> getUserDetails() async {
    return this.storageService.getUserDetails();
  }

  Future<RegistrationResponse> register(int profileCreatedFor, String email,
      String phoneCode, String mobile, Gender gender, String password) async {
    return this.apiClient.registerUser(
        profileCreatedFor, email, phoneCode, mobile, gender, password);
  }

  Future<SigninResponse> login(String email, String password) async {
    return this.apiClient.signinUser(email, password);
  }

  Future<SigninResponse> about(
      MaritalStatus maritalStatus,
      AbilityStatus abilityStatus,
      ChildrenStatus childrenStatus,
      HeightStatus heightStatus,
      String dob,
      String name) async {
    return this.apiClient.aboutVerification(
        maritalStatus, abilityStatus, childrenStatus, heightStatus, dob, name);
  }

  Future<SigninResponse> habit(EatingHabit eatingHabit,
      SmokingHabit smokingHabit, DrinkingHabit drinkingHabit) async {
    return this
        .apiClient
        .habitVerification(eatingHabit, smokingHabit, drinkingHabit);
  }

  Future<MasterDataResponse> getMasterData() async {
    return apiClient.getMasterData(null);
  }

  saveUserDetails() async {
    this.storageService.saveUserDetails(this.useDetails!);
  }
}
