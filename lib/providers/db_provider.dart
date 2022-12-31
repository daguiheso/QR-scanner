import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider {

  // propiedad estatica para acceder a la instancia de la DB
  static Database? _database;
  // instancia de custom class
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async => _database ??= await initDB();

  Future<Database>  initDB() async {
    // path DB
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    // Create DB
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
        ''');
      }
    );

  }

  newScanRaw( ScanModel newScan) async {

    final id = newScan.id;
    final type = newScan.type;
    final value = newScan.value;

    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, type, value)
        VALUES($id, '$type', '$value')
    ''');

    return res;
  }

  Future<int> newScan(ScanModel newScan) async {

    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());

    // id new register
    return res;
  }
}