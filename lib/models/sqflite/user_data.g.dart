// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// SqflModelGenerator
// **************************************************************************

extension UserDataSqfl on UserData {
  static const tableUserData = "UserData";
  static const colUserId = "userId";
  static const typeOfUserId = "TEXT NOT NULL";
  static const colData = "data";
  static const typeOfData = "TEXT NOT NULL";
  static const colType = "type";
  static const typeOfType = "TEXT NOT NULL";

  Map<String, Object?> toMap() => {
        colUserId: userId,
        colData: data,
        colType: type,
      };

  static UserData fromMap(Map<String, Object?> map) => UserData(
        userId: map[colUserId] as String,
        data: map[colData] as String,
        type: map[colType] as String,
      );
}
