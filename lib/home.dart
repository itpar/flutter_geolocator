import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double lat;
  double lng;
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) {
      setState(() {
        lat = res.latitude;
        lng = res.longitude;
      });
    });

    // Track user Movements
    location.onLocationChanged.listen((res) {
      setState(() {
        lat = res.latitude;
        lng = res.longitude;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geolocation"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text("Lat: $lat, Lng: $lng"),
              ),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                child: Text("Track My Location"),
                onPressed: () => _locateMe(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
