import 'package:flutter/material.dart';
import 'package:google_map_test/controllers/api_helper.dart';
import 'package:google_map_test/models/location_model.dart';

class LocationListScreen extends StatefulWidget {
  const LocationListScreen({super.key});

  @override
  State<LocationListScreen> createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  LocationModel? locationModel;
  bool _isLoading = true;

  getLocation() async {
    var res = await ApiHelper().getLocationData();
    setState(() {
      locationModel = res;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButton(),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height - 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: locationModel!.data!.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    locationModel!.data![index].flag!,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width - 84,
                                    child: Text(
                                      locationModel!.data![index].name!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                  "latitude : ${locationModel!.data![index].location!.latitude}"),
                              Text(
                                  "longitude : ${locationModel!.data![index].location!.longitude}"),
                              Text(
                                  "phone code: ${locationModel!.data![index].phoneCode}")
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
          ),
    );
  }
}
