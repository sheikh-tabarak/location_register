import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<String> FetchCurrentLocation() async {
  bool ServiceEnable;
  LocationPermission permission;

  ServiceEnable = await Geolocator.isLocationServiceEnabled();

  if (!ServiceEnable) {
    Fluttertoast.showToast(msg: "Location Service not enabled");
  }

  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(msg: "You denied the permission");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Fluttertoast.showToast(msg: "You Denied Permission Forever");
  }

  Position _currentPosition = await Geolocator.getCurrentPosition();

  String _currentAddress = "";
  await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude)
      .then((List<Placemark> placemarks) {
    Placemark place = placemarks[0];

    // Need to add like this as per instructions
    // { Block /Apt number-name ,Street,city,District,pincode }

    // String blockAptNumber = placemark.subThoroughfare;
    // String street = placemark.thoroughfare;
    // String city = placemark.locality;
    // String district = placemark.subAdministrativeArea;
    // String pincode = placemark.postalCode;

    _currentAddress =
        '${place.subThoroughfare},${place.thoroughfare}, ${place.locality}, ${place.subAdministrativeArea},${place.postalCode}';

    //${place.subAdministrativeArea}, ${place.country},${place.postalCode} ';

    // 1600 Amphitheatre Pkwy, California,Santa Clara County, United States,94043

    //  1600,Amphitheatre Parkway, Mountain View, Santa Clara County,94043
    // });
  }).catchError((e) {
    debugPrint(e);
    print(e);
  });

  return _currentAddress;
}
