// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CfsModelGenerator
// **************************************************************************

extension UserCfs on User {
  static const docUser = "User";
  static const keyUserId = "userId";
  static const keyName = "name";
  static const keyProfilePicUrl = "profilePicUrl";
  static const keyPhoneNos = "phoneNos";
  static const keyEmailIds = "emailIds";
  static const keyAddresses = "addresses";

  Map<String, Object?> toMap() => {
        keyUserId: userId,
        keyName: name,
        keyProfilePicUrl: profilePicUrl,
        keyPhoneNos: phoneNos,
        keyEmailIds: emailIds,
        keyAddresses: addresses,
      };

  static User fromSnapshot(DocumentSnapshot<Map<String, Object?>> snap) => User(
        userId: snap.id,
        name: snap[keyName] as String,
        profilePicUrl: snap[keyProfilePicUrl] as String?,
        phoneNos: (snap[keyPhoneNos] as List)
            .map((item) => item as String)
            .toList(growable: false),
        emailIds: (snap[keyEmailIds] as List)
            .map((item) => item as String)
            .toList(growable: false),
        addresses: (snap[keyAddresses] as List)
            .map((item) => item as String)
            .toList(growable: false),
      );
}
