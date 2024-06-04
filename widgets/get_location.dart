import 'package:location/location.dart';
import 'package:flutter/services.dart';

Future<LocationData?> retrieveLocation() async {
  LocationData? locationData;
  Location locationService = Location();
  try {
    var _serviceEnabled = await locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationService.requestService();
      if (!_serviceEnabled) {
        print('Failed to enable service. Returning.');
        return null;
      }
    }

    var _permissionGranted = await locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Location service permission not granted. Returning.');
        return null;
      }
    }

    locationData = await locationService.getLocation();
  } on PlatformException catch (e) {
    print('Error: ${e.toString()}, code: ${e.code}');
    locationData = null;
  }
  locationData = await locationService.getLocation();
  return locationData;
}
