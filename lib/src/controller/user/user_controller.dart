import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pixel_maker/src/controller/image/image_state.dart';
import 'package:pixel_maker/src/controller/user/user_state.dart';
import 'package:pixel_maker/src/model/pixel_model.dart';
import 'package:state_notifier/state_notifier.dart';

class UserController extends StateNotifier<UserState> {
  final _db = FirebaseFirestore.instance;
  UserController() : super(const UserState()) {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      state = state.copyWidth(user: event, userName: event?.uid);
      initUserInfo();
    });
  }

  Future<void> updataName(String name) async {
    await _db.collection('user').doc(state.user?.uid).set({
      'userName': name,
    });
    state = state.copyWidth(userName: name);
  }

  Future<void> initUserInfo() async {
    final data = await _db.collection('user').doc(state.user?.uid).get();
    if (!data.exists) throw Exception('No user data');
    state = state.copyWidth(userName: data.data()?['userName']);
  }

  Future<bool> uploadNewImage(int size, List<List<PixelModel>> pixels) async {
    try {
      await _db.collection('image').add({
        'creator': state.userName,
        'size': size,
        'pixels': [
          for (final row in pixels)
            for (final e in row) e.color.value,
        ],
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> updateImage(
      String docId, int size, List<List<PixelModel>> pixels) async {
    try {
      await _db.collection('image').doc(docId).update({
        'creator': state.userName,
        'size': size,
        'pixels': [
          for (final row in pixels)
            for (final e in row) e.color.value,
        ],
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
