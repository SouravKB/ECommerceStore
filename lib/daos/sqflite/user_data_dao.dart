import 'package:ecommercestore/database/sqflite_database.dart';
import 'package:ecommercestore/models/sqflite/user_data.dart';
import 'package:sqflite/sqflite.dart';

class UserDataDao {
  UserDataDao._();

  static final instance = UserDataDao._();

  static const _tableUserData = 'UserData';

  void insertUserData(UserData userData) async {
    await (await SqfliteDatabase.instance).insert(
        _tableUserData, userData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void deleteUserData(UserData userData) async {
    await (await SqfliteDatabase.instance).delete(_tableUserData,
        where: 'userId = ? AND data = ? AND type = ?',
        whereArgs: [userData.userId, userData.data, userData.type]);
  }

  Future<List<UserData>> getUserDataList(String userId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableUserData, where: 'userId = ?', whereArgs: [userId]);
    return result
        .map((res) => UserDataSqfl.fromMap(res))
        .toList(growable: false);
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
    CREATE TABLE UserData (
    userId ${UserDataSqfl.typeOfUserId},
    data ${UserDataSqfl.typeOfData},
    type ${UserDataSqfl.typeOfType},
    FOREIGN KEY(userId) REFERENCES User(userId)
    )
    ''');
  }
}
