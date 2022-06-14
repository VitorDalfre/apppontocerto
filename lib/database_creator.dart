import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

import 'global.dart';

class DatabaseCreator {
  StringBuffer sql = StringBuffer();

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    if (!await Directory(dirname(path)).exists()) {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('ponto');
    dbMaster = await openDatabase(path,
        version: 1, onCreate: onCreate, onUpgrade: onUpgrade);
    print("Banco criado:");
    print(dbMaster!);
  }

  Future<void> onCreate(Database db, int version) async {
    await createTable(db: db, version: version);
  }

  Future onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future createTable({Database? db, int? version}) async {
    sql.write(" CREATE TABLE IF NOT EXISTS usuario ( ");
    sql.write(" id INTEGER PRIMARY KEY, ");
    sql.write(" login TEXT, ");
    sql.write(" senha TEXT, ");
    sql.write(" nome TEXT, ");
    sql.write(" chaveGerente TEXT, ");
    sql.write(" gerente BOOLEAN DEFAULT FALSE ) ");

    await db!.execute(sql.toString());

    sql = StringBuffer();

    sql.write(" CREATE TABLE IF NOT EXISTS banco_horas (");
    sql.write(" id INTEGER PRIMARY KEY, ");
    sql.write(" idusuario INTEGER DEFAULT 0, ");
    sql.write(" FOREIGN KEY(idusuario) REFERENCES usuario(id)");
    sql.write(" )");
    await db.execute(sql.toString());

    sql = StringBuffer();

    sql.write("CREATE TABLE IF NOT EXISTS horarios_registrados (");
    sql.write(" id INTEGER PRIMARY KEY, ");
    sql.write(" idusuario INTEGER NOT NULL, ");
    sql.write(" data TEXT, ");
    sql.write(" horario TEXT, ");
    sql.write(" FOREIGN KEY(idusuario) REFERENCES banco_horas(idusuario)");
    sql.write(" )");
    await db.execute(sql.toString());
  }
}
