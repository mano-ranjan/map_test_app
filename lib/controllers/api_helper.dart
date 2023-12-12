import 'dart:convert';

import 'package:google_map_test/models/location_model.dart';
import 'package:http/http.dart' as http;
class ApiHelper{
  static String baseUrl = "https://api.staging-tech.shdesk.com/v1/list/countries";

  Future<LocationModel> getLocationData() async {
    final res = await http.get(Uri.parse(baseUrl));
    var data = jsonDecode(res.body);
    LocationModel locationModel = LocationModel();
    if(res.statusCode == 200){
      locationModel = LocationModel.fromJson(data);
      locationModel.errorMessage = "no Error";
      return locationModel;
    } else {
      locationModel.errorMessage = "Error Occurred";
      return locationModel;
    }
  }
}