import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:makemymarry/repo/chat_repo.dart';
import 'package:makemymarry/repo/user_repo.dart';

final getIt = GetIt.instance;

final logger = Logger();

Future<void> setUpDependency() async {
  /// Flutter service
  getIt
    ..registerSingleton<ChatRepo>(ChatRepo(
        firestore: FirebaseFirestore.instance,
        chatService: FirebaseChatCore.instance))
    ..registerSingleton<UserRepository>(UserRepository())
  ;
}
