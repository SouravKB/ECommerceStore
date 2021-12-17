import 'dart:async';

import 'package:location/location.dart';

class LocationService {
  LocationService._();

  static Future<Location?> _initLocationService() async {
    final location = Location();

    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return location;
  }

  static final instance = _initLocationService();
}

extension LocStream on Location {
  Stream<LocationData> getLocationStream() {
    final controller = StreamController<LocationData>();
    onLocationChanged.listen(controller.add);
    return controller.stream;
  }
}
