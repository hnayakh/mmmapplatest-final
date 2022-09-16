import 'package:dio/dio.dart';
import 'package:makemymarry/datamodels/connect.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/matching_percentage_response.dart';
import 'package:makemymarry/datamodels/recharge.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/utils/api_client.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/storage_service.dart';
import 'package:makemymarry/views/home/matching_profile/matching_profile.dart';

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

  Future<SigninResponse> logout(String email, String password) async {
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

  // Future<ProfileDataResponse> getAllUsersProfileData(String id) async {
  //   return apiClient.getAllUsersProfileData(id);
  // }

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

  Future<CheckEmailResponse> checkEmail(String email) async {
    return this.apiClient.checkEmail(email);
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

  Future<SigninResponse> updateBio(String aboutMe, List<String> images) async {
    return apiClient.updateBio(aboutMe, images, useDetails!.id);
  }

  Future<SigninResponse> career(
      // String nameOfOrg,
      String? occupation,
      AnualIncome income,
      String? education,
      CountryModel country,
      StateModel stateName,
      StateModel city) async {
    return apiClient.careerVerification(occupation, income, education, country,
        stateName, city, useDetails!.id);
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

  Future<PreSignUrlResponse> getImagePreSignedUrl(String imageName) async {
    return apiClient.getPreSignedUrl(imageName, this.useDetails!.id);
  }

  Future<Response?> uploadFile(String url, String name, String path) {
    return apiClient.uploadFile(url, name, path);
  }

  Future<MatchingProfileResponse> getMyMatchingProfile() async {
    return this.apiClient.getMyMatchingProfile(this.useDetails!.id);
  }

  Future<MatchingProfileResponse> getProfileVisitor() async {
    return this.apiClient.getProfileVisitor(this.useDetails!.id);
  }

  Future<MatchingProfileResponse> getRecentViews() async {
    return this.apiClient.getRecentViews(this.useDetails!.id);
  }

  Future<ProfileDetailsResponse> getOtheruserDetails(
      String id, ProfileActivationStatus activationStatus) async {
    return apiClient.getOtherUserDetails(id, activationStatus);
  }

  Future<String?> uploadImage(String images) async {
    print("saurabh uplaod");
    return apiClient.uploadImage(useDetails!.id, images);
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
      AbilityStatus abilityStatus) async {
    return this.apiClient.completePreference(
        maxHeight,
        minHeight,
        maxAge,
        minAge,
        maritalStatus,
        countryModel,
        myState,
        city,
        religion,
        subCaste,
        motherTongue,
        occupation,
        education,
        annualIncome,
        eatingHabit,
        drinkingHabit,
        smokingHabit,
        abilityStatus,
        useDetails!.id);
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
      AbilityStatus abilityStatus) async {
    return this.apiClient.completeFilter(
        maxHeight,
        minHeight,
        maxAge,
        minAge,
        maritalStatus,
        countryModel,
        myState,
        city,
        religion,
        subCaste,
        motherTongue,
        occupation,
        education,
        annualIncome,
        eatingHabit,
        drinkingHabit,
        smokingHabit,
        abilityStatus,
        useDetails!.id);
  }

  void updateRegistrationStep(int i) async {
    await this.storageService.updateRegistrationStep(i);
  }

  Future<LikeStatusResponse> setLikeStatus(
      String likedUserId, String likedByUserId) {
    return this.apiClient.setLikeStatus(likedUserId, likedByUserId);
  }

  Future<InterestResponse> getInterestList(String id) async {
    return await this.apiClient.getInterestList(id);
  }

  Future<LikeStatusResponse> cancelSentInterest(
      String currentUser, String otherUser, String requestId) async {
    return await this
        .apiClient
        .cancelSentInterest(currentUser, otherUser, requestId);
  }

  Future<LikeStatusResponse> rejectReceivedInterest(
      String currentUser, String otherUser, String requestId) async {
    return await this
        .apiClient
        .rejectReceivedInterest(currentUser, otherUser, requestId);
  }

  Future<LikeStatusResponse> acceptReceivedInterest(
      String currentUser, String otherUser, String requestId) async {
    return await this
        .apiClient
        .acceptReceivedInterest(currentUser, otherUser, requestId);
  }

  Future<CouponDetailsResponse> validateCoupon(String coupon) async {
    return this.apiClient.validateCoupon(coupon);
  }

  Future<ConnectPriceDetailsResponse> getConnectPrice() async {
    return this.apiClient.getConnectPriceDetails();
  }

  Future<SimpleResponse> recharge(RechargeModel rechargeModel) async {
    return this.apiClient.recharge(rechargeModel);
  }

  Future<CurrentBalanceResponse> fetchCurrentBalance() async {
    return this.apiClient.fetchCurrentBalance(this.useDetails!.id);
  }

  Future<RechargeHistoryResponse> getTransactionHistory() async {
    return this.apiClient.getTransactionHistory(this.useDetails!.id);
  }

  Future<ConnectResponse> connectUsers(String connectById, String connectToId) {
    return this.apiClient.connectUsers(connectById, connectToId);
  }

  Future<MyConnectResponse> getMyConnects() async {
    return this.apiClient.getMyConnects(this.useDetails!.id);
  }

  Future visitProfile(String id) async {
    return this.apiClient.visitProfile(id, this.useDetails!.id);
  }

  Future<ConnectHistoryResponse> getCOnnecHistory() async {
    return this.apiClient.getConnectHistory(this.useDetails!.id);
  }

  Future<MySearchResponse> getConnectThroughMMId(displayId) async {
    var userDetails = await getUserDetails();
    return this.apiClient.getConnectThroughMMId(userDetails!.id, displayId);
  }

  Future<MatchingPercentageResponse> getMatchPercentage(otherBasicId) async {
    var userDetails = await getUserDetails();

    // return this.apiClient.getMatchPercentage(userDetails!.id, otherBasicId);
    return this.apiClient.getMatchPercentage(
        "39222b1b-07e4-46a6-a504-9a521380d099",
        "a6e1b1af-a3d4-47cd-b4e0-88070996cd61");
  }
}
