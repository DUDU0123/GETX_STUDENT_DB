import 'package:getx_student_db/data/database_creation.dart';
import 'package:getx_student_db/model/student_database_model.dart';
import 'package:sqflite/sqflite.dart';

class DbFunctions {
  late DataBaseCreation _dbCreation;
  DbFunctions() {
    _dbCreation = DataBaseCreation();
  }
  static Database? _db;
  Future<Database?> get database async {
    if (_db != null) {
      // if database is alreay created or opened
      return _db;
    } else {
      // if database didn't opened before, just wait for getting created or open, and we can return
      _db = await _dbCreation.createDB();
      return _db;
    }
  }

  inserDataToDB(table, data) async {
    var db = await database;
    return await db?.insert(table, data);
  }

  getAllDataFromDB(table) async {
    var db = await database;
    return await db?.query(table);
  }

  getDataFromDBbyId(table, StudentDataBaseModel student) async {
    var db = await database;
    var result = await db
        ?.query(table, where: 'name LIKE ?', whereArgs: ['%${student.name}%']);
    if (result != null && result.isNotEmpty) {
      return result;
    } else {
      return null; // Return null if no records are found
    }
  }

  updateOneUserInDB(table, data) async {
    var db = await database;
    return await db?.update(
      table,
      data,
      where: 'id=?',
      whereArgs: [data['id']],
    );
  }

  deleteDataById(table, userId) async {
    var db = await database;
    return await db?.rawDelete(
      'delete from $table where id=$userId',
    );
  }
}
