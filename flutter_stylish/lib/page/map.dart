import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_stylish/helper/style_constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapPage extends StatefulWidget {
  const MapPage({Key? key,}) : super(key: key);
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _markers = <Marker>{};
  final double _zoom = 10;
  final CameraPosition _initialPosition = const CameraPosition(target: LatLng(26.8206, 30.8025));

  late GoogleMapController _controller;
  late String _mapStyle;

  @override
  void initState() {
    rootBundle.loadString('assets/map_style.json').then((string) {
      _mapStyle = string;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar,
      endDrawer: _endDrawer(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (controller) {
              _controller = controller;
              _controller.setMapStyle(_mapStyle);
            },
            initialCameraPosition: _initialPosition,
          ),
        ],
      ),
    );
  }

  Widget _endDrawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 50),
          const ListTile(
            title: Text("Stores"),
            leading: Icon(Icons.store),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              _goToNewYork();
              Navigator.of(context).pop();
            },
            title: const Text("New York"),
            leading: const Icon(Icons.arrow_back_ios),
          ),
          ListTile(
            onTap: () {
              _goToNewDelhi();
              Navigator.of(context).pop();
            },
            title: const Text("New Delhi"),
            leading: const Icon(Icons.arrow_back_ios),
          ),
          ListTile(
            onTap: () {
              _goToLondon();
              Navigator.of(context).pop();
            },
            title: const Text("London"),
            leading: const Icon(Icons.arrow_back_ios),
          ),
          ListTile(
            onTap: () {
              _goToTokyo();
              Navigator.of(context).pop();
            },
            title: const Text("Tokyo"),
            leading: const Icon(Icons.arrow_back_ios),
          ),
          ListTile(
            onTap: () {
              _goToDubai();
              Navigator.of(context).pop();
            },
            title: const Text("Dubai"),
            leading: const Icon(Icons.arrow_back_ios),
          ),
          ListTile(
            onTap: () {
              _goToParis();
              Navigator.of(context).pop();
            },
            title: const Text("Paris"),
            leading: const Icon(Icons.arrow_back_ios),
          )
        ],
      ),
    );
  }

  Future<void> _goToNewYork() async {
    double lat = 40.7128;
    double long = -74.0060;
    _controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: const MarkerId('newyork'),
            position: LatLng(lat, long),
            infoWindow: const InfoWindow(
                title: 'New York', snippet: 'Welcome to New York')),
      );
    });
  }

  Future<void> _goToNewDelhi() async {
    double lat = 28.644800;
    double long = 77.216721;
    _controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: const MarkerId('newdelhi'),
            position: LatLng(lat, long),
            infoWindow: const InfoWindow(
                title: 'New Delhi', snippet: 'Welcome to New Delhi')),
      );
    });
  }

  Future<void> _goToLondon() async {
    double lat = 51.5074;
    double long = -0.1278;
    _controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: const MarkerId('london'),
            position: LatLng(lat, long),
            infoWindow: const InfoWindow(
                title: 'London', snippet: 'Welcome to London')),
      );
    });
  }

  Future<void> _goToTokyo() async {
    double lat = 35.6795;
    double long = 139.77171;
    _controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: const MarkerId('tokyo'),
            position: LatLng(lat, long),
            infoWindow:
                const InfoWindow(title: 'Tokyo', snippet: 'Welcome to Tokyo')),
      );
    });
  }

  Future<void> _goToDubai() async {
    double lat = 25.2048;
    double long = 55.2708;
    _controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: const MarkerId('dubai'),
            position: LatLng(lat, long),
            infoWindow:
                const InfoWindow(title: 'Dubai', snippet: 'Welcome to Dubai')),
      );
    });
  }

  Future<void> _goToParis() async {
    double lat = 48.8566;
    double long = 2.3522;
    _controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: const MarkerId('paris'),
            position: LatLng(lat, long),
            infoWindow:
                const InfoWindow(title: 'Paris', snippet: 'Welcome to Paris')),
      );
    });
  }
}
