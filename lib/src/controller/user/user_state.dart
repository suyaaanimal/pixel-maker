import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class UserState {
  const UserState({
    this.userName = '',
    this.user,
  });
  final String userName;
  final User? user;
  UserState copyWidth({
    String? userName,
    User? user,
  }) =>
      UserState(
        userName: userName ?? this.userName,
        user: user ?? this.user,
      );
}
