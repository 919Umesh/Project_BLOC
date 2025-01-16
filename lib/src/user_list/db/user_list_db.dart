import 'package:project_bloc/src/user_list/model/user_list_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import '../../../app/temp/custom_log.dart';
import '../../../core/services/database/database_const.dart';
import '../../../core/services/database/database_provider.dart';


class UserListDatabase {
  Database? db;

  UserListDatabase._privateConstructor();

  static final UserListDatabase instance =
  UserListDatabase._privateConstructor();

  //Insert data to local database
  Future<int> insertData(UserModel data) async {
    db = await DatabaseHelper.instance.database;
    return await db!.insert(
      DatabaseDetails.userListTable,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Delete all the table data
  Future deleteData() async {
    String myQuery = '''  DELETE FROM ${DatabaseDetails.userListTable}  ''';
    db = await DatabaseHelper.instance.database;
    return await db!.rawQuery(myQuery);
  }

  Future<List<UserModel>> getDataList() async {
    db = await DatabaseHelper.instance.database;
    String myQuery = '''  SELECT * FROM ${DatabaseDetails.userListTable} ''';
    final List<Map<String, dynamic>> mapData = await db!.rawQuery(myQuery);
    CustomLog.successLog(value: "MapData => $mapData");
    return List.generate(mapData.length, (i) {
      return UserModel.fromJson(mapData[i]);
    });
  }
}
