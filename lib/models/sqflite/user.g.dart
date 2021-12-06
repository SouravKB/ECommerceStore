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
  static const colProfilePicUrl = "profilePicUrl";
  static const typeOfProfilePicUrl = "TEXT";

  Map<String, Object?> toMap() => {
        colUserId: userId,
        colName: name,
        colProfilePicUrl: profilePicUrl,
      };

  static User fromMap(Map<String, Object?> map) => User(
        userId: map[colUserId] as String,
        name: map[colName] as String,
        profilePicUrl: map[colProfilePicUrl] as String?,
      );
}
