import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scan = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Center(
        child: Text(scan['value']),
      ),
    );
  }
}