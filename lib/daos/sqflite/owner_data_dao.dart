import 'package:ecommercestore/database/sqflite_database.dart';
import 'package:ecommercestore/models/sqflite/owner_data.dart';
import 'package:sqflite/sqflite.dart';

class OwnerDataDao {
  OwnerDataDao._();

  static final instance = OwnerDataDao._();

  static const _tableOwnerData = 'OwnerData';

  void insertOwnerData(OwnerData ownerData) async {
    await (await SqfliteDatabase.instance).insert(
        _tableOwnerData, ownerData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void deleteOwnerData(OwnerData ownerData) async {
    await (await SqfliteDatabase.instance).delete(_tableOwnerData,
        where: 'ownerId = ? AND data = ? AND type = ?',
        whereArgs: [ownerData.ownerId, ownerData.data, ownerData.type]);
  }

  Future<List<OwnerData>> getOwnerDataList(String ownerId) async {
    final result = await (await SqfliteDatabase.instance)
        .query(_tableOwnerData, where: 'ownerId = ?', whereArgs: [ownerId]);
    return result
        .map((res) => OwnerDataSqfl.fromMap(res))
        .toList(growable: false);
  }

  static Future<void> createTable(Database db) async {
    await db.execute('''
    CREATE TABLE OwnerData (
    ownerId ${OwnerDataSqfl.typeOfOwnerId},
    data ${OwnerDataSqfl.typeOfData},
    type ${OwnerDataSqfl.typeOfType},
    FOREIGN KEY(ownerId) REFERENCES User(userId)
    )
    ''');
  }
}
