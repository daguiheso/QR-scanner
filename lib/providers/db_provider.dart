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

  Future<ScanModel?> getScanById(int id) async {

    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty
      ? ScanModel.fromJson(res.first)
      : null;
  }

  Future<List<ScanModel>?> getAllScans() async {

    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
      ? res.map((s) => ScanModel.fromJson(s)).toList()
      : [];
  }

  Future<List<ScanModel>?> getScansByType(String type) async {

    final db = await database;
    final res = await db.query('Scans', where: 'type = ?', whereArgs: [type]);

    return res.isNotEmpty
      ? res.map((s) => ScanModel.fromJson(s)).toList()
      : [];
  }

  Future<int> updateScan(ScanModel newScan) async {

    final db = await database;
    final res = await db.update('Scans', newScan.toJson(), where: 'id = ?', whereArgs: [newScan.id]);

    return res;
  }

  Future<int> deleteScanById(int id) async {

    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteAllScans() async {

    final db = await database;
    final res = await db.delete('Scans');

    return res;
  }

  Future<int> deleteAllScansRaw() async {

    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');

    return res;
  }
}