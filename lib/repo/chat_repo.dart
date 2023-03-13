import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:makemymarry/utils/utility_service.dart';

class ChatRepo {

  final FirebaseFirestore firestore;
  final FirebaseChatCore chatService;
  ChatRepo({required this.firestore, required this.chatService});

  Future<void> createChatUser({
    required String id,
    required String fullName,
    required String imageUrl,
  }) async {
    try {
      final user = types.User(
        id: id,
        firstName: fullName.trim().split(" ").first,
        lastName: fullName.trim().split(" ").length > 1
            ? fullName.trim().split(" ")[1]
            : "",
        imageUrl: imageUrl,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      );
      await chatService.createUserInFirestore(user);
    } catch (e, stackTrace) {
      UtilityService.cprint(e.toString(), stackTrace: stackTrace);
    }
  }

  Future<void> updateChatUser({
    required String id,
    required String fullName,
    required String imageUrl,
  }) async {
    try {
      var docRef = await firestore.collection('users').doc(id).get();
      if (docRef.exists) {
        await docRef.reference.update({
          'firstName': fullName.trim().split(" ").first,
          'lastName': fullName.trim().split(" ").length > 1
              ? fullName.trim().split(" ")[1]
              : "",
          'imageUrl': imageUrl,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        final user = types.User(
          id: id,
          firstName: fullName.trim().split(" ").first,
          lastName: fullName.trim().split(" ").length > 1
              ? fullName.trim().split(" ")[1]
              : "",
          imageUrl: imageUrl,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          updatedAt: DateTime.now().millisecondsSinceEpoch,
        );
        await chatService.createUserInFirestore(user);
      }
    } catch (e, stackTrace) {
      UtilityService.cprint(e.toString(), stackTrace: stackTrace);
    }
  }

  Future<types.User> getChatUser({
    required String id,
  }) async {
    try {
      final userData =
          (await firestore.collection('users').doc(id).get()).data();
      if (userData != null) {
        userData['createdAt'] = userData['createdAt']?.millisecondsSinceEpoch;
        userData['id'] = id;
        userData['lastSeen'] = userData['lastSeen']?.millisecondsSinceEpoch;
        userData['updatedAt'] = userData['updatedAt']?.millisecondsSinceEpoch;
        return types.User.fromJson(userData);
      } else {
        throw Exception("Chat User does not exist");
      }
    } catch (e, stackTrace) {
      UtilityService.cprint(e.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<types.Room> getChatRoom(String userId, types.User otherUser) async {
    try {
      final userIds = [userId, otherUser.id]..sort();

      final roomQuery = await firestore
          .collection('rooms')
          .where('type', isEqualTo: types.RoomType.direct.toShortString())
          .where('userIds', isEqualTo: userIds)
          .limit(1)
          .get();
      if (roomQuery.docs.isNotEmpty) {
        var data = roomQuery.docs.first.data();
        var userDetails = await getChatUser(id: userId);
        var otherUserDetails = otherUser;
        var room = types.Room(
            id: roomQuery.docs.first.id,
            type: types.RoomType.direct,
            users: [userDetails, otherUserDetails],
            name:
                (otherUser.firstName ?? "") + " " + (otherUser.lastName ?? ""),
            imageUrl: otherUser.imageUrl ?? "");
        return room;
      } else {
        var generatedRoom = await firestore.collection('rooms').add({
          'createdAt': FieldValue.serverTimestamp(),
          'imageUrl': otherUser.imageUrl ?? "",
          'metadata': null,
          'name':
              (otherUser.firstName ?? "") + " " + (otherUser.lastName ?? ""),
          'type': types.RoomType.direct.toShortString(),
          'updatedAt': FieldValue.serverTimestamp(),
          'userIds': userIds,
          'userRoles': null,
        });
        var userDetails = await getChatUser(id: userId);
        var otherUserDetails = otherUser;
        var room = types.Room(
            id: generatedRoom.id,
            type: types.RoomType.direct,
            users: [userDetails, otherUserDetails],
            name:
                (otherUser.firstName ?? "") + " " + (otherUser.lastName ?? ""),
            imageUrl: otherUser.imageUrl ?? "");
        return room;
      }
    } catch (e, stackTrace) {
      UtilityService.cprint(e.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> sendMessage(
      String roomId, dynamic partialMessage, String userId) async {
    try {
      types.Message? message;

      if (partialMessage is types.PartialCustom) {
        message = types.CustomMessage.fromPartial(
          author: types.User(id: userId),
          id: '',
          partialCustom: partialMessage,
        );
      } else if (partialMessage is types.PartialFile) {
        message = types.FileMessage.fromPartial(
          author: types.User(id: userId),
          id: '',
          partialFile: partialMessage,
        );
      } else if (partialMessage is types.PartialImage) {
        message = types.ImageMessage.fromPartial(
          author: types.User(id: userId),
          id: '',
          partialImage: partialMessage,
        );
      } else if (partialMessage is types.PartialText) {
        message = types.TextMessage.fromPartial(
          author: types.User(id: userId),
          id: '',
          partialText: partialMessage,
        );
      }

      if (message != null) {
        final messageMap = message.toJson();
        messageMap.removeWhere((key, value) => key == 'author' || key == 'id');
        messageMap['authorId'] = userId;
        messageMap['createdAt'] = FieldValue.serverTimestamp();
        messageMap['updatedAt'] = FieldValue.serverTimestamp();

        await firestore
            .collection('${'rooms'}/$roomId/messages')
            .add(messageMap);

        await firestore
            .collection('rooms')
            .doc(roomId)
            .update({'updatedAt': FieldValue.serverTimestamp()});
      }
    } catch (e) {}
  }

  Future<void> updateOnlineStatus(
      {required bool isOnline, required String userId}) async {
    try {
      var docRef = await firestore.collection('users').doc(userId).get();
      if (docRef.exists) {
        if (isOnline) {
          await docRef.reference.update({
            'metadata': {'onlineStatus': isOnline}
          });
        } else {
          await docRef.reference.update({
            'metadata': {'onlineStatus': isOnline},
            'lastSeen': FieldValue.serverTimestamp()
          });
        }
        print("userId $userId's online status ==>> $isOnline updated");
      }
    } catch (e, stacktrace) {
      UtilityService.cprint(e.toString(), stackTrace: stacktrace);
    }
  }

  Stream<List<String>> getOnlineUsersStream() {
    try {
      var docRef = firestore
          .collection('users')
          .where('metadata', isEqualTo: {'onlineStatus': true});
      return docRef
          .snapshots()
          .asyncMap((query) => query.docs.map((e) => e.id).toList())
          .asBroadcastStream();
    } catch (e, stacktrace) {
      UtilityService.cprint(e.toString(), stackTrace: stacktrace);
      rethrow;
    }
  }

  Future<List<String>> getOnlineUsers() async {
    try {

      var docRef = firestore
          .collection('users')
          .where('metadata', isEqualTo: {'onlineStatus': true});
      var res =  await docRef.get();
      var ids = <String>[];
      res.docs.forEach((element) {
        ids.add(element.id);
      });
      return ids;
    } catch (e, stacktrace) {
      UtilityService.cprint(e.toString(), stackTrace: stacktrace);
      rethrow;
    }
  }
  Stream<bool> getOnlineStatus(String userId) {
    try {
      var docRef = firestore.collection('users').doc(userId);


      return docRef.snapshots().asyncMap(
          (event) async => (await event.get('metadata'))['onlineStatus']);
    } catch (e, stacktrace) {
      print("---------------------- >>>>");
      UtilityService.cprint(e.toString(), stackTrace: stacktrace);
      rethrow;
    }
  }

  Future<int> getMessageCount(
      {required String userId, required String otherUser}) async {
    try {
      final userIds = [userId, otherUser]..sort();

      final roomQuery = await firestore
          .collection('rooms')
          .where('type', isEqualTo: types.RoomType.direct.toShortString())
          .where('userIds', isEqualTo: userIds)
          .limit(1)
          .get();
      if (roomQuery.docs.isNotEmpty) {
        return (await roomQuery.docs.first.reference
                .collection('messages')
                .count()
                .get())
            .count;
      } else {
        return 0;
      }
    } catch (e, stacktrace) {
      UtilityService.cprint(e.toString(), stackTrace: stacktrace);
      rethrow;
    }
  }
}
