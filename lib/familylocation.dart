import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class MapScreen extends StatelessWidget {

  final double lat ;
  final double long ;

  const MapScreen({super.key , required this.lat, required this.long});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Family Location", style: TextStyle(fontSize: 28),)),
      body: FlutterMap(
        options: MapOptions(
          interactiveFlags:InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          center: LatLng(lat, long),
          zoom: 13,
        ),
        nonRotatedChildren: [
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () {
                },
              ),
            ],
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                  width: 50.0,
                  height: 50.0,
                  point: LatLng(lat, long),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 30,
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
