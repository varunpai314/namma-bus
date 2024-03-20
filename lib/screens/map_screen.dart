import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:namma_bus/conponents/search.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  final LatLng _center =
      const LatLng(13.1234, 74.9876); // Coordinates for Nmamit, Nitte
  // final TextEditingController _destinationController = TextEditingController();
  // final TextEditingController _startController = TextEditingController();

  // bool _showForm = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 8.0, // Adjust the zoom level to show a 90km radius
              ),
              markers: _markers,
            ),
            const Search(),
            // AnimatedPositioned(
            //   duration: const Duration(milliseconds: 300),
            //   bottom: _showForm ? 0.0 : -200.0,
            //   left: 0.0,
            //   right: 0.0,
            //   child: Container(
            //     padding: const EdgeInsets.all(16.0),
            //     color: Colors.white,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.stretch,
            //       children: [
            //         TextField(
            //           controller: _destinationController,
            //           decoration:
            //               const InputDecoration(labelText: 'Destination'),
            //         ),
            //         const SizedBox(height: 12.0),
            //         ElevatedButton(
            //           onPressed: () {
            //             // Handle form submission
            //           },
            //           child: const Text('Submit'),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     setState(() {
        //       _showForm = !_showForm;
        //     });
        //   },
        //   child: Icon(_showForm ? Icons.arrow_downward : Icons.arrow_upward),
        // ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // Add markers for destinations
    _addMarker(const LatLng(13.1234, 74.9876), 'Destination 1');
    // Add more markers as needed
  }

  void _addMarker(LatLng position, String markerId) {
    final Marker marker = Marker(
      markerId: MarkerId(markerId),
      position: position,
      infoWindow: InfoWindow(title: markerId, snippet: 'Destination'),
      onTap: () {
        setState(() {});
      },
    );

    setState(() {
      _markers.add(marker);
    });
  }

  // @override
  // void dispose() {
  //   _destinationController.dispose();
  //   _startController.dispose();
  //   super.dispose();
  // }
}
