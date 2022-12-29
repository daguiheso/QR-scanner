import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/custom_navigation_bar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete)
            )
        ],
      ),
      body: Center(
         child: Text('HomePage'),
      ),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}