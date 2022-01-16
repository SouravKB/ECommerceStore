import 'dart:math';

import 'package:location/location.dart';

extension Distance on LocationData {
  double distanceFrom(LocationData other) =>
      sqrt(pow(other.latitude! - latitude!, 2) +
          pow(other.longitude! - longitude!, 2));
}
