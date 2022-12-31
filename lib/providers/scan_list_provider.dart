import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  newScan(String value) async {
    final newScan = ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);
    // assign ID from DB to model
    newScan.id = id;

    if (selectedType == newScan.type) {
      scans.add(newScan);
      notifyListeners();
    }
  }

  loadScans() async {
    final allScans = await DBProvider.db.getAllScans();

    scans = [...allScans!];
    notifyListeners();
  }

  loadScanByType(String type) async {
    final allScans = await DBProvider.db.getScansByType(type);

    scans = [...allScans!];
    selectedType = type;
    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScanById(id);
    // loadScanByType(selectedType);
  }
}
