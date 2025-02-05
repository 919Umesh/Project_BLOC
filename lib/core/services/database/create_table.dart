import 'package:sqflite/sqflite.dart';
import 'database_const.dart';

class CreateTable {
  Database db;

  CreateTable(this.db);

  userListTable() async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ${DatabaseDetails.userListTable} (
        ${DatabaseDetails.id} TEXT,
        ${DatabaseDetails.name} TEXT ,
        ${DatabaseDetails.email} TEXT,
        ${DatabaseDetails.v} TEXT
      )
    ''');
  }
}
