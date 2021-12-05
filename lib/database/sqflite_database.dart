import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabase {
  static Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'ecommercestore.db'),
      version: 1,
      onCreate: (db, version) => _createDatabase(db, version),
    );
  }

  static void _createDatabase(Database db, int version) async {
    switch (version) {
      case 1:
        // TODO add table creations here.
        return;
    }
  }

  static final instance = _initDatabase();
}
