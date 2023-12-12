import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_test/controllers/api_helper.dart';
import 'package:google_map_test/controllers/constants.dart';
import 'package:google_map_test/models/location_model.dart';
import 'package:google_map_test/views/location_list_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  bool _isLoading = true;
  LocationModel? locationModel;


  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);

    setState(() {
      _currentPosition = location;
      _isLoading = false;
    });
    _list.add(
      Marker(
        markerId: const MarkerId('current'),
        position: _currentPosition!,
        infoWindow: const InfoWindow(title: 'Current Location'),
        icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          "assets/pngs/shdesk_logo.png",
        ),
      ),
    );
    locationModel = await ApiHelper().getLocationData();
  }

  final List<Marker> _list = [
     const Marker(
      markerId: MarkerId('1'),
      position: LatLng(23.0225, 72.5714),
      infoWindow: InfoWindow(
        title: 'hey Ahmedabad',
      ),
    ),
    const Marker(
      markerId: MarkerId('2'),
      position: LatLng(17.4065, 78.4772),
      infoWindow: InfoWindow(
        title: 'come to hyderabad anna for biyani😛',
      ),
    ),
    const Marker(
      markerId: MarkerId('3'),
      position: LatLng(39, -122),
      infoWindow: InfoWindow(
        title: 'My Current Location 3',
      ),
    ),
    const Marker(
      markerId: MarkerId('4'),
      position: LatLng(24, 87),
      infoWindow: InfoWindow(
        title: 'Rampurhat',
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _currentPosition!,
                  zoom: 4,
                ),
                markers: Set<Marker>.of(_list),
                mapType: MapType.normal,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,),
        child: Row(
          children: [
            FloatingActionButton(
              heroTag: "btn 1",
              onPressed: () async {
                getLocation();
                GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _currentPosition!,
                      zoom: 14,
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.my_location_sharp,
              ),
            ),
            const SizedBox(width: 20,),
            FloatingActionButton(
              heroTag: "btn 2",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LocationListScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
