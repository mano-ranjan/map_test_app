class LocationModel {
  String? errorMessage;
  List<Data>? data;
  Meta? meta;
  Null? error;

  LocationModel({this.data, this.meta, this.error});

  LocationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? code;
  String? flag;
  Location? location;
  bool? serviceAvailable;
  String? phoneCode;

  Data(
      {this.id,
        this.name,
        this.code,
        this.flag,
        this.location,
        this.serviceAvailable,
        this.phoneCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    flag = json['flag'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    serviceAvailable = json['service_available'];
    phoneCode = json['phone_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['flag'] = flag;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['service_available'] = serviceAvailable;
    data['phone_code'] = phoneCode;
    return data;
  }
}

class Location {
  String? latitude;
  String? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class Meta {
  String? message;
  String? url;

  Meta({this.message, this.url});

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['url'] = url;
    return data;
  }
}
