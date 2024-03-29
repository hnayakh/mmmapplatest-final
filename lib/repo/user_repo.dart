import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:makemymarry/datamodels/agora_token_response.dart';
import 'package:makemymarry/datamodels/blocked_users_response.dart';
import 'package:makemymarry/datamodels/connect.dart';
import 'package:makemymarry/datamodels/interests_model.dart';
import 'package:makemymarry/datamodels/martching_profile.dart';
import 'package:makemymarry/datamodels/master_data.dart';
import 'package:makemymarry/datamodels/matching_percentage_response.dart';
import 'package:makemymarry/datamodels/notification_response.dart';
import 'package:makemymarry/datamodels/recharge.dart';
import 'package:makemymarry/datamodels/user_model.dart';
import 'package:makemymarry/locator.dart';
import 'package:makemymarry/utils/api_client.dart';
import 'package:makemymarry/utils/mmm_enums.dart';
import 'package:makemymarry/utils/storage_service.dart';
import 'package:makemymarry/views/meet/bloc/meet_form_bloc.dart';

class UserRepository {
  late StorageService storageService;
  ApiClient apiClient = ApiClient();
  ProfileDetails? profileDetails;
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

  Future<SigninResponse> updateLifeStyle(String uid, List<String> data) async {
    return this.apiClient.updateLifeStyle(uid, data);
  }

  Future<SigninResponse> updateHobby(String uid, List<String> data) async {
    return this.apiClient.updateHobby(uid, data);
  }

  Future<AgoraTokenResponse> generateAgoraToken(
      String callerId, CallType type) async {
    var currentUser = await getUserDetails();
    var id = currentUser!.id;
    var res = await this.apiClient.generateAgoraToken(
        type: type, calleUserId: callerId, callerUserId: id);
    if (res.token != null) {
      FirebaseFirestore.instance
          .collection('activeCalls')
          .doc(res.token!.notificationId)
          .set({'status': true});
    }
    return res;
  }

  Future updateRegistartionStep(String basicUserId, int step) async {
    return this.apiClient.updateRegistartionStep(basicUserId, step);
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
    return this.apiClient.sendOtp(dialCode, mobile, login, email);
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

  Future<DocumentUploadResponse> updateDoc(
      IdProofType idProof, List<String> images) async {
    return apiClient.updateDoc(idProof, images, useDetails!.id);
  }

  Future<SigninResponse> career(
      // String nameOfOrg,
      String? occupation,
      AnnualIncome income,
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
    StateModel city,
    bool isResidingWithFamily,
  ) async {
    return apiClient.updateFamilyBackground(familyAfluenceLevel, familyValues,
        type, countryModel, state, city, useDetails!.id, isResidingWithFamily);
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

  Future<PremiumMembersResponse> getPremiumMembers() async {
    return this.apiClient.getPremiumMembers(this.useDetails!.id);
  }

  Future<ProfileVisitedResponse> getProfileVisitor() async {
    return this.apiClient.getProfileVisitor(this.useDetails!.id);
  }

  Future<MatchingProfileResponse> getOnlineMembers(
      List<String> onlineUserIds) async {
    return this.apiClient.getOnlineMembers(this.useDetails!.id, onlineUserIds);
  }

  Future<RecentViewsResponse> getRecentViews() async {
    return this.apiClient.getRecentViews(this.useDetails!.id);
  }

  Future<MeetListResponse> fetchALlMeets() async {
    return this.apiClient.fetchAllMeets(this.useDetails!.id);
  }

  Future<dynamic> createMeetRequest({
    required DateTime scheduleTime,
    required MeetType meetType,
    required String otherUserId,
    required LatLng latLng,
    required String location,
  }) async {
    return this.apiClient.createMeetRequest(
        scheduleTime: scheduleTime,
        meetType: meetType,
        otherUserId: otherUserId,
        latLng: latLng,
        location: location,
        id: getIt<UserRepository>().useDetails!.id);
  }

  Future<dynamic> updateMeetRequest({
    required DateTime scheduleTime,
    required Activeconnection meet,
    required LatLng latLng,
    required String location,
  }) async {
    return this.apiClient.updateMeetRequest(
        scheduleTime: scheduleTime,
        latLng: latLng,
        location: location,
        meet: meet);
  }

  Future<dynamic> updateMeetStatus({
    required Activeconnection meet,
    required int status,
  }) async {
    return this.apiClient.updateMeetStatus(
        meet: meet, status: status, id: getIt<UserRepository>().useDetails!.id);
  }

  Future<dynamic> updateSettings({
    required bool showEmail,
    required bool showPhone,
    required bool isHidden,
    required bool isNotification,
  }) async {
    return this
        .apiClient
        .updateSettings(
        showEmail: showEmail,
        showPhone: showPhone,
        isHidden: isHidden,
        isNotification: isNotification,
        userId: getIt<UserRepository>().useDetails!.id);
  }

  Future<SettingsDataResponse> getSettings() async {
    return this
        .apiClient
        .getSettingsData(userId: getIt<UserRepository>().useDetails!.id);
  }

  Future<ProfileDetailsResponse> getOtheruserDetails(
      String id, ProfileActivationStatus activationStatus) async {
    var details = await getUserDetails();
    return apiClient.getOtherUserDetails(id, activationStatus,
        userId: details?.id);
  }

  Future<NotificationResponse> getNotifications(
    String id,
  ) async {
    return apiClient.getNotifications(id);
  }

  Future<BlockedUsersResponse> getBlockedUsers(
    String id,
  ) async {
    return apiClient.getBlockedUsers(id);
  }

  Future<PartnerPreferenceResponse> getPartnerPreference() async {
    var details = await getUserDetails();
    return apiClient.getPartnerPreference(userId: details!.id);
  }

  Future<ProfileDetailsResponse> getOtherUserDetailsByDisplayId(
      String displayId,
      ProfileActivationStatus activationStatus,
      String? userId) async {
    return apiClient.getOtherUserDetailsByDisplayId(
        displayId, activationStatus, userId);
  }

  Future<String?> uploadImage(String images) async {
    print("saurabh uplaod");
    return apiClient.uploadImage(useDetails!.id, images);
  }

  Future<String?> uploadDocImage(String images, String userBasicId) async {
    print("saurabh uplaod$userBasicId");
    return apiClient.uploadDocImage(userBasicId, images);
  }

  // Future<String?> uploadDocument(String images) async {
  //   print("Akash uplaod");
  //   return apiClient.uploadImage(useDetails!.id, images);
  // }

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
        annualIncomeMax,
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
        annualIncomeMax,
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
      String likedUserId, String likedByUserId, String? requestId) {
    return this.apiClient.setLikeStatus(likedUserId, likedByUserId, requestId);
  }

  Future<dynamic> blockProfile(String blockBy, String blockTo) {
    return this.apiClient.blockProfile(blockBy, blockTo);
  }

  Future<dynamic> unBlockProfile(String blockId) {
    return this.apiClient.unblockProfile(blockId);
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

    return this.apiClient.getMatchPercentage(userDetails!.id, otherBasicId);
    // return this.apiClient.getMatchPercentage(
    //     "39222b1b-07e4-46a6-a504-9a521380d099",
    //     "a6e1b1af-a3d4-47cd-b4e0-88070996cd61");
  }
}
