import 'package:ecommercestore/models/sqflite/user.dart';
import 'package:ecommercestore/services/sqflite_database.dart';
import 'package:sqflite/sqflite.dart';

class UserDao {
  UserDao._();

  static final instance = UserDao._();

  static const _tableUser = 'User';

  Future<void> insertUser(User user) async {
    await (await SqfliteDatabase.instance).insert(_tableUser, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteUser(String userId) async {
    await (await SqfliteDatabase.instance)
        .delete(_tableUser, where: 'userId = ?', whereArgs: [userId]);
  }

  Future<User?> getUser(String userId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableUser, where: 'userId = ?', whereArgs: [userId]);
    if (result.isEmpty) return null;
    return UserSqfl.fromMap(result[0]);
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
    CREATE TABLE User (
    userId ${UserSqfl.typeOfUserId} PRIMARY KEY,
    name ${UserSqfl.typeOfName},
    profilePicUrl ${UserSqfl.typeOfProfilePicUrl}
    )
    ''');
  }
}
