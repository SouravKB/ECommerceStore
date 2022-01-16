import 'dart:async';

import 'package:location/location.dart';

class LocationService {
  LocationService._();

  static final _loc = _initLocationService();

  static Future<Location?> _initLocationService() async {
    final location = Location();

    var isEnabled = await location.serviceEnabled();
    if (!isEnabled) {
      isEnabled = await location.requestService();
      if (!isEnabled) {
        return null;
      }
    }

    var permStatus = await location.hasPermission();
    if (permStatus == PermissionStatus.denied) {
      permStatus = await location.requestPermission();
      if (permStatus != PermissionStatus.granted) {
        return null;
      }
    }

    return location;
  }

  Future<LocationData?> getLocation() async {
    final loc = await _loc;
    if (loc != null) return loc.getLocation();
    return null;
  }

  Stream<LocationData?> getLocationStream() async* {
    final loc = await _loc;
    if (loc != null) yield* loc.onLocationChanged;
  }

  static final instance = LocationService._();
}
