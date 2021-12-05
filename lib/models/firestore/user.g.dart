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
  static const keyEmailIds = "emailIds";
  static const keyPhoneNos = "phoneNos";
  static const keyAddresses = "addresses";

  Map<String, Object?> toMap() => {
        keyUserId: userId,
        keyName: name,
        keyProfilePicUrl: profilePicUrl,
        keyEmailIds: emailIds,
        keyPhoneNos: phoneNos,
        keyAddresses: addresses,
      };

  static User fromSnapshot(DocumentSnapshot<Map<String, Object?>> snap) => User(
        userId: snap.id,
        name: snap[keyName] as String,
        profilePicUrl: snap[keyProfilePicUrl] as String?,
        emailIds: snap[keyEmailIds] as List<String>,
        phoneNos: snap[keyPhoneNos] as List<String>,
        addresses: snap[keyAddresses] as List<String>,
      );
}
