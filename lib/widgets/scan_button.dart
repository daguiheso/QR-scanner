import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //   '#3D8BEF',
        //   'Cancelar',
        //   false,
        //   ScanMode.QR
        // );
        const barcodeScanRes = 'http://www.google.com';
        // const barcodeScanRes = 'geo:4.648804,-74.077778';

        if (barcodeScanRes == '-1') return;

        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        final ScanModel newScan = await scanListProvider.newScan(barcodeScanRes);

        launchUrl(context, newScan);
      }
    );
  }
}