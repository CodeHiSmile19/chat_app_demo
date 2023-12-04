import 'package:chat_app_demo/models/entities/account_entity.dart';
import 'package:chat_app_demo/models/entities/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FireStorageService {
  final CollectionReference _accountCollectionReference =
  FirebaseFirestore.instance.collection('account');

  final CollectionReference _messagesCollectionReference =
  FirebaseFirestore.instance.collection('messages');

  final CollectionReference _roomsCollectionReference =
  FirebaseFirestore.instance.collection('rooms');

  Future createUser(AccountEntity authenticateInfo) async {
    try {
      await _accountCollectionReference.doc(authenticateInfo.uId).set(
        authenticateInfo.toJson(),
      );
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future<List<AccountEntity>?> getListAccount() async {
    try {
      var accountDocumentSnapshot = await _accountCollectionReference.get();

      if (accountDocumentSnapshot.docs.isNotEmpty) {
        return accountDocumentSnapshot.docs
            .map(
              (snapshot) =>
              AccountEntity.fromJson(
                snapshot.data() as Map<String, dynamic>,
              ),
        )
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint("Đã xảy ra lỗi không lấy về được danh sách account");
      return null;
    }
  }

  Future<AccountEntity?> searchUser(String phoneNumber) async {
    try {
      var accountDocumentSnapshot = await _accountCollectionReference.get();

      if (accountDocumentSnapshot.docs.isNotEmpty) {
        final listAccount = accountDocumentSnapshot.docs
            .map(
              (snapshot) =>
              AccountEntity.fromJson(
                snapshot.data() as Map<String, dynamic>,
              ),
        )
            .toList();

        final accounts = listAccount
            .where((element) => element.phoneNumber == phoneNumber)
            .toList();

        if (accounts.isNotEmpty) {
          return accounts.first;
        }

        return null;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Đã xảy ra lỗi lấy về account");
      return null;
    }
  }

  Future<AccountEntity?> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      var accountDocumentSnapshot = await _accountCollectionReference.get();

      if (accountDocumentSnapshot.docs.isNotEmpty) {
        final listAccount = accountDocumentSnapshot.docs
            .map(
              (snapshot) =>
              AccountEntity.fromJson(
                snapshot.data() as Map<String, dynamic>,
              ),
        )
            .toList();

        final accounts = listAccount
            .where((element) =>
        element.phoneNumber == phoneNumber &&
            element.passWord == password)
            .toList();

        if (accounts.isNotEmpty) {
          return accounts.first;
        }

        return null;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Đã xảy ra lỗi đăng nhập");
      return null;
    }
  }

  Future createRoom({
    required String senderId,
    required String receiveId,
  }) async {
    try {
      await _roomsCollectionReference
          .doc("$senderId-$receiveId")
          .collection("$senderId-$receiveId")
          .doc()
          .set(message.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future createMessage({
    required String senderId,
    required String receiveId,
    String? content,
    String? image,
  }) async {
    try {
      final MessageEntity message = MessageEntity(
        senderId: senderId,
        receiverId: receiveId,
        messageBody: content,
        isImage: (image ?? '').isNotEmpty,
        imageUrl: image,
      );

      await _messagesCollectionReference
          .doc("$senderId-$receiveId")
          .collection("$senderId-$receiveId")
          .doc()
          .set(message.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getListMessage({
    required String senderId,
    required String receiveId,
  }) async {
    try {
      QuerySnapshot<Map<String, dynamic>> response;

      response = await _messagesCollectionReference
          .doc("$senderId-$receiveId")
          .collection("chats")
          .get();

      if (response.docs.isEmpty) {
        response = await _messagesCollectionReference
            .doc("$receiveId-$senderId")
            .collection("chats")
            .get();
      } else {
        final listMessageOfUser = response.docs
            .map(
              (snapshot) =>
              MessageEntity.fromJson(
                snapshot.data(),
              ),
        )
            .toList();

        final allMessages = listMessageOfUser
            .where((element) =>
        element.senderId == senderId || element.receiverId == senderId)
            .toList();

        if (allMessages.isNotEmpty) {
          final result = allMessages
              .where((element) =>
          element.senderId == receiveId ||
              element.receiverId == receiveId)
              .toList();
          return result;
        }

        return null;
      }
    else {
    return null;
    }
    } catch (e) {
    debugPrint("Đã xảy ra lỗi lấy về account");
    return null;
    }
  }
}
