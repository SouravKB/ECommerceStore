import 'package:ecommercestore/daos/firestore/user_dao.dart' as firestore_daos;
import 'package:ecommercestore/daos/sqflite/user_dao.dart' as sqflite_daos;
import 'package:ecommercestore/daos/sqflite/user_data_dao.dart' as sqflite_daos;
import 'package:ecommercestore/models/firestore/user.dart' as firestore_models;
import 'package:ecommercestore/models/sqflite/user.dart' as sqflite_models;
import 'package:ecommercestore/models/sqflite/user_data.dart' as sqflite_models;
import 'package:ecommercestore/models/ui/user.dart';

class UserRepo {
  UserRepo._();

  static final instance = UserRepo._();

  final _firestoreUserDao = firestore_daos.UserDao.instance;
  final _sqfliteUserDao = sqflite_daos.UserDao.instance;
  final _sqfliteUserDataDao = sqflite_daos.UserDataDao.instance;

  Stream<User> getUserStream(String userId) async* {
    await for (final cfsUser in _firestoreUserDao.getUserStream(userId)) {
      final sqflUser = sqflite_models.User(
          userId: cfsUser.userId,
          name: cfsUser.name,
          profilePicUrl: cfsUser.profilePicUrl);
      _sqfliteUserDao.insertUser(sqflUser);

      for (final data in cfsUser.emailIds) {
        final userData = sqflite_models.UserData(
            userId: cfsUser.userId, data: data, type: 'emailId');
        _sqfliteUserDataDao.insertUserData(userData);
      }

      for (final data in cfsUser.phoneNos) {
        final userData = sqflite_models.UserData(
            userId: cfsUser.userId, data: data, type: 'phoneNo');
        _sqfliteUserDataDao.insertUserData(userData);
      }

      for (final data in cfsUser.addresses) {
        final userData = sqflite_models.UserData(
            userId: cfsUser.userId, data: data, type: 'address');
        _sqfliteUserDataDao.insertUserData(userData);
      }

      yield User(
          userId: cfsUser.userId,
          name: cfsUser.name,
          profilePicUrl: cfsUser.profilePicUrl,
          emailIds: cfsUser.emailIds,
          phoneNos: cfsUser.phoneNos,
          addresses: cfsUser.addresses);
    }
  }

  Future<void> addUser(User user) async {
    await updateUser(user);
  }

  Future<void> updateUser(User user) async {
    final cfsUser = firestore_models.User(
        userId: user.userId,
        name: user.name,
        profilePicUrl: user.profilePicUrl,
        emailIds: user.emailIds,
        phoneNos: user.phoneNos,
        addresses: user.addresses);
    await _firestoreUserDao.setUser(cfsUser);
  }

  Future<void> deleteUser(String userId) async {
    await _firestoreUserDao.deleteUser(userId);
  }
}
