import 'package:sqflite/sqflite.dart';
import 'package:crud_test/db_helper/database_connection.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  //Adiciona usuario
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Le tudo salvo
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //le o ID
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //Atualiza o usario
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Deleta o usario
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}
