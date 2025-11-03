import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapTab extends StatefulWidget {
  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  Location location = Location();

  late LocationData userLocation;

  LatLng? intiLocation;

  @override
  void initState() {
    super.initState();
    initializeMap();
  }

  @override
  Widget build(BuildContext context) {
    return intiLocation == null
        ? Center(child: CircularProgressIndicator())
        : GoogleMap(
      // cloudMapId: ,
      tiltGesturesEnabled: false,
      compassEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              zoom: 15,
              target: intiLocation ?? LatLng(0, 0),
            ),
          );
  }

  Future<void> initializeMap() async {
    bool enableService = await location.serviceEnabled();

    if (!enableService) {
      enableService = await location.requestService();
    }
    if (!enableService) {
      return;
    }

    PermissionStatus permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied ||
        permissionStatus == PermissionStatus.deniedForever) {
      permissionStatus = await location.requestPermission();
    }
    if (permissionStatus != PermissionStatus.granted) {
      //error dialog
      return;
    }

    userLocation = await location.getLocation();
    setState(() {
      intiLocation = LatLng(userLocation.latitude!, userLocation.longitude!);
    });
  }
}
