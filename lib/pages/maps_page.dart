import 'package:flutter/material.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(Icons.map, color: Theme.of(context).primaryColor),
        title: Text('http://eppepe...'),
        subtitle: Text('ID: 1'),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        onTap: () => print('abrir algo...'),
      )
    );
  }
}