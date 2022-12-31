import 'dart:io';

import 'package:geolocator/geolocator.dart';

class DataWeHave {
  Position? position;
  File? image;

  DataWeHave({this.position, this.image});
}
