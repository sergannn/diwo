import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart' as gl;

class MapBoxLocationExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LocationExampleState();
}

class LocationExampleState extends State<MapBoxLocationExample> {
  StreamSubscription? userPositionStream;
  var isLight = true;
  mp.MapboxMap? mapboxMap;
  bool _isMapCreated = false;

  @override
  void initState() {
    super.initState();
    mp.MapboxOptions.setAccessToken(
        "pk.eyJ1Ijoic2VyZ2Fubm4iLCJhIjoiY2w2NWw0ejZ3MDdmZDNpbm84eWtqOWx0cSJ9.KdhQrNoti2fgGSRSqDiyHQ");
  }

  @override
  void dispose() {
    userPositionStream?.cancel();
    mapboxMap?.dispose();
    super.dispose();
  }

  void _onMapCreated(mp.MapboxMap mapboxMap) {
    if (_isMapCreated) return; // Prevent multiple initializations

    this.mapboxMap = mapboxMap;
    _isMapCreated = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLocation();
    });
  }

  Future<void> _initializeLocation() async {
    var status = await Permission.location.status;
    print(status);
    if (status.isGranted) {
      await _setupLocation();
    } else if (status.isPermanentlyDenied) {
      _showPermissionDeniedDialog();
    } else {
      status = await Permission.location.request();
      if (status.isGranted) {
        await _setupLocation();
      }
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Location Permission Required'),
        content: Text(
          'This app needs location permissions to show your location on the map. '
          'Please go to app settings and grant the permission.',
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Open Settings'),
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _setupLocation() async {
    if (mapboxMap == null) return;

    bool serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    mapboxMap?.location.updateSettings(
      mp.LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
        showAccuracyRing: true,
        puckBearingEnabled: true,
      ),
    );

    userPositionStream?.cancel();
    userPositionStream = gl.Geolocator.getPositionStream(
      locationSettings: const gl.LocationSettings(),
    ).listen((gl.Position? position) {
      if (position != null && mapboxMap != null) {
        mapboxMap?.easeTo(
          mp.CameraOptions(
            bearing: position.heading,
            pitch: 0,
            center: mp.Point(
              coordinates: mp.Position(position.longitude, position.latitude),
            ),
          ),
          mp.MapAnimationOptions(duration: 2000, startDelay: 0),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(isLight ? Icons.light_mode : Icons.dark_mode),
              heroTag: null,
              onPressed: () {
                setState(() => isLight = !isLight);
                if (isLight) {
                  mapboxMap?.loadStyleURI(mp.MapboxStyles.LIGHT);
                } else {
                  mapboxMap?.loadStyleURI(mp.MapboxStyles.DARK);
                }
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      body: Stack(children: [
        mp.MapWidget(
          styleUri: mp.MapboxStyles.DARK,
          key: UniqueKey(),
          onMapCreated: _onMapCreated,
          cameraOptions: mp.CameraOptions(
            zoom: 15,
            pitch: 55,
          ),
        ),
      ]),
    );
  }
}
