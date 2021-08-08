import 'package:makemymarry/utils/storage_service.dart';

class UserRepository {
  late StorageService storageService;

  UserRepository() {
    this.storageService = StorageService();
  }

  Future<bool?> getHasOpenedBefore() async {
    return this.storageService.isFirstTimeLogin();
  }

  Future<String?> getUserDetails() async {
    return this.storageService.getUserDetails();
  }
}
