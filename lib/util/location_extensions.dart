import 'dart:math';

import 'package:geocoding/geocoding.dart';

extension Distance on Location {
  double distanceFrom(Location other) => sqrt(
      pow(other.latitude - latitude, 2) + pow(other.longitude - longitude, 2));
}
