// ignore_for_file: unused_element

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationService {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  static Future<dynamic?> getLocation(Position position) async {
    String url =
        'https://api.opencagedata.com/geocode/v1/json?q=${position.latitude}+${position.longitude}&key=250d7e0d05b64342866a536d06ea24a0';
    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      dynamic dt = json.decode(res.body);
      if (dt['results'].length > 0) {
        return dt['results'][0]['components'] ?? '';
      }
    }
  }

  static Future<int?> getLocationDangerLevel(Position position) async {
    final String response = await rootBundle.loadString('assets/district.json');
    final data = await json.decode(response);
    dynamic location = await getLocation(position);
    String district = location['city'];
    try {
      return int.parse(data[district.toUpperCase()]);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
