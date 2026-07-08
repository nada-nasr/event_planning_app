import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../utils/app_styles.dart';

class MapSelectionScreen extends StatefulWidget {
  static const String routeName = 'MapSelectionScreen';

  const MapSelectionScreen({super.key});

  @override
  State<MapSelectionScreen> createState() => _MapSelectionScreenState();
}

class _MapSelectionScreenState extends State<MapSelectionScreen> {
  LatLng? selectedLocation;

  GoogleMapController? mapController;

  void onMapTapped(LatLng latLng) {
    setState(() {
      selectedLocation = latLng;
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Location', style: AppStyles.medium20Primary),

        actions: [
          IconButton(
            onPressed:
                selectedLocation == null
                    ? null
                    : () {
                      Navigator.pop(context, selectedLocation);
                    },

            icon: const Icon(Icons.check),
          ),
        ],
      ),

      body: GoogleMap(
        zoomControlsEnabled: false,

        onMapCreated: onMapCreated,

        onTap: onMapTapped,

        initialCameraPosition: const CameraPosition(
          target: LatLng(30.0444, 31.2357), // Initial center (Suez)

          zoom: 12,
        ),

        markers:
            selectedLocation == null
                ? {}
                : {
                  Marker(
                    markerId: const MarkerId('selected_location'),

                    position: selectedLocation!,
                  ),
                },
      ),
    );
  }
}
