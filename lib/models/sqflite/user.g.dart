// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// SqflModelGenerator
// **************************************************************************

extension UserSqfl on User {
  static const tableUser = "User";
  static const colUserId = "userId";
  static const typeOfUserId = "TEXT NOT NULL";
  static const colName = "name";
  static const typeOfName = "TEXT NOT NULL";
  static const colProfilePic = "profilePic";
  static const typeOfProfilePic = "TEXT";

  Map<String, Object?> toMap() => {
        colUserId: userId,
        colName: name,
        colProfilePic: profilePic,
      };

  static User fromMap(Map<String, Object?> map) => User(
        userId: map[colUserId] as String,
        name: map[colName] as String,
        profilePic: map[colProfilePic] as String?,
      );
}
