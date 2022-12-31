import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

import 'package:qr_reader/widgets/custom_navigation_bar.dart';
import 'package:qr_reader/widgets/scan_button.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
            IconButton(
              onPressed: () {
                final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
                scanListProvider.deleteAllScans();
              },
              icon: const Icon(Icons.delete)
            )
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    // connect with provider
    final uiProvider = Provider.of<UiProvider>(context);
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    final currentIndex = uiProvider.selectedMenuOpt;

    switch(currentIndex) {
      case 0:
        scanListProvider.loadScanByType('geo');
        return const ScanTiles(type: 'geo');

      case 1:
        scanListProvider.loadScanByType('http');
        return const ScanTiles(type: 'http');

      default:
        return const ScanTiles(type: 'geo');
    }

  }
}