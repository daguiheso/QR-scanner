import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final scan = ModalRoute.of(context)?.settings.arguments as ScanModel;

    CameraPosition initialPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 22,
      tilt: 120,
    );

    Set<Marker> markers = Set<Marker>();
    markers.add(Marker(
      markerId: const MarkerId('geo-location'),
      position: scan.getLatLng()
    ));

    Future<void> goToInitialPosition() async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(initialPoint));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
            onPressed: () => goToInitialPosition(),
            icon: const Icon(Icons.center_focus_strong)
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapType = mapType == MapType.normal ? MapType.satellite : MapType.normal;
          setState(() {});
        },
        child: const Icon(Icons.layers)
      ),
    );
  }
}
