import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> launchUrl(BuildContext context, ScanModel scan) async {
  final url = scan.value;

  if (scan.type == 'http') {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan.toJson());
  }

}