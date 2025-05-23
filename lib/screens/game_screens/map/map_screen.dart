import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/start_screens/start_screen.dart';
import 'package:flutter_application_1/utils/auth/auth.dart';
import 'package:flutter_application_1/screens/main_widgets/drawer.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
    _disposeMapboxMap(); // Add this
//    mapboxMap?.dispose();
    super.dispose();
  }

  Future<void> _disposeMapboxMap() async {
    try {
      mapboxMap?.dispose();
    } catch (e) {
      debugPrint('Error disposing map: $e');
    } finally {
      mapboxMap = null;
      _isMapCreated = false;
    }
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

  Future<void> _goToCurrentLocation() async {
    try {
      final position = await gl.Geolocator.getCurrentPosition();

      if (mapboxMap != null && mounted) {
        mapboxMap?.flyTo(
          mp.CameraOptions(
            center: mp.Point(
                coordinates:
                    mp.Position(position.longitude, position.latitude)),
            zoom: 15,
            bearing: position.heading,
          ),
          mp.MapAnimationOptions(duration: 2000),
        );

        // Update location puck
        mapboxMap?.location.updateSettings(
          mp.LocationComponentSettings(
            enabled: true,
            pulsingEnabled: true,
            puckBearingEnabled: true,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Couldn't get location: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isMapCreated && mapboxMap == null) {
        _initializeLocation();
      }
    });
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF020E18),
          title: const Text(''),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          )),
      drawer: myDrawer(context),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        // Current Location Button
        FloatingActionButton(
          heroTag: 'location', // Unique tag required when multiple FABs
          mini: true,
          onPressed: _goToCurrentLocation,
          child: Icon(Icons.my_location),
        ),
        SizedBox(height: 16),
        FloatingActionButton(
            onPressed: () async {
              context.loaderOverlay.show();
              await StorageService.logout();
              context.loaderOverlay.hide();
              Navigator.pushReplacementNamed(context, '/splash');
              /*   Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const StartScreen()),
              (route) => false, // Remove all routes
            );*/
            },
            child: Text("выход"))
      ]),
      body: Stack(children: [
        mp.MapWidget(
          styleUri: mp.MapboxStyles.DARK,
          //    key: UniqueKey(),
          key: ValueKey(_isMapCreated),
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
