// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_data.dart';

// **************************************************************************
// SqflModelGenerator
// **************************************************************************

extension OwnerDataSqfl on OwnerData {
  static const tableOwnerData = "OwnerData";
  static const colOwnerId = "ownerId";
  static const typeOfOwnerId = "TEXT NOT NULL";
  static const colData = "data";
  static const typeOfData = "TEXT NOT NULL";
  static const colType = "type";
  static const typeOfType = "TEXT NOT NULL";

  Map<String, Object?> toMap() => {
        colOwnerId: ownerId,
        colData: data,
        colType: type,
      };

  static OwnerData fromMap(Map<String, Object?> map) => OwnerData(
        ownerId: map[colOwnerId] as String,
        data: map[colData] as String,
        type: map[colType] as String,
      );
}
