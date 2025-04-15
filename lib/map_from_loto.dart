import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart' as gl;

class MapBoxLocationExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LocationExampleState();
}

class LocationExampleState extends State<MapBoxLocationExample> {
  StreamSubscription? userPositionStream;
//  LocationExampleState();
  var isLight = true;
  final colors = [Colors.amber, Colors.black, Colors.blue];
  mp.MapboxMap? mapboxMap;
  bool isInitialized = false; // Track initialization status

  _onMapCreated(mp.MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    _initializeLocation();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeLocation();
    });
//    _initializeLocation();
  }

  @override
  void dispose() {
    userPositionStream?.cancel();
    super.dispose();
  }

  Widget _show() {
    return TextButton(
      child: Text('show location'),
      onPressed: () {
        mapboxMap?.location
            .updateSettings(mp.LocationComponentSettings(enabled: true));
      },
    );
  }

  Future<void> _initializeLocation() async {
    bool serviceEnabled;
    gl.LocationPermission permission;
    final status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
      mapboxMap?.location.updateSettings(mp.LocationComponentSettings(
          locationPuck: mp.LocationPuck(
              locationPuck3D: mp.LocationPuck3D(
                  modelRotation: [-0, 0, 90],
                  modelUri:
                      "https://derevni-i-syola.ru/image/tesla_model_s_plaid_2023.glb",
                  modelScale: [0.5, 0.5, 0.5]))));
      mapboxMap?.location.updateSettings(
        mp.LocationComponentSettings(
          enabled: true,
          pulsingEnabled: true,
          showAccuracyRing: true,
          puckBearingEnabled: true,
        ),
      );

      gl.LocationSettings locationSettings = gl.LocationSettings();
      userPositionStream?.cancel();
      userPositionStream =
          gl.Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((gl.Position? position) async {
        if (position != null) {
//          print(position);
          print("heading is");
          final cameraState = mapboxMap?.getCameraState();
          print(position.heading);
          //    mapboxMap?.getElevation(coordinate)
          /*  mp.CameraOptions? myOptions = await mapboxMap
              ?.cameraForCoordinatesPadding(
                  [
                mp.Point(
                    coordinates:
                        mp.Position(position.longitude, position.latitude))
              ],
                  mp.CameraOptions(

                      //zoom: 24,
                      //anchor: mp.ScreenCoordinate(x: 0.5, y: 140),
                      bearing: position.heading,
                      pitch: 80,
                      center: mp.Point(
                          // bbox: mp.BBox(lng1, lat1, alt1, lng2),
                          coordinates: mp.Position(
                              position.longitude, position.latitude))),
                  mp.MbxEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                  20,
                  mp.ScreenCoordinate(x: 100, y: 20));*/
          //   mapboxMap?.easeTo(myOptions!,
          //     mp.MapAnimationOptions(duration: 2000, startDelay: 0));
          mapboxMap?.easeTo(
              mp.CameraOptions(

                  //zoom: 24,
                  //anchor: mp.ScreenCoordinate(x: 0.5, y: 140),
                  bearing: position.heading,
                  pitch: 0,
                  center: mp.Point(
                      // bbox: mp.BBox(lng1, lat1, alt1, lng2),
                      coordinates:
                          mp.Position(position.longitude, position.latitude))),
              mp.MapAnimationOptions(duration: 2000, startDelay: 0));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    mp.MapboxOptions.setAccessToken(
        "pk.eyJ1Ijoic2VyZ2Fubm4iLCJhIjoiY2w2NWw0ejZ3MDdmZDNpbm84eWtqOWx0cSJ9.KdhQrNoti2fgGSRSqDiyHQ");

    /* final mp.MapWidget mapWidget = mp.MapWidget(
      key: ValueKey("mapWidget"),
      onMapCreated: _onMapCreated,
      cameraOptions: mp.CameraOptions(
          //  center: Point(coordinates: centerPosition),
          zoom: 17,
          //   bearing: 15,
          pitch: 55),
    );*/

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
                    setState(
                      () => isLight = !isLight,
                    );
                    if (isLight) {
                      mapboxMap?.loadStyleURI(mp.MapboxStyles.LIGHT);
                    } else {
                      mapboxMap?.loadStyleURI(mp.MapboxStyles.DARK);
                    }
                  }),
              SizedBox(height: 10),
            ],
          ),
        ),
        body: Stack(children: [
          mp.MapWidget(
            styleUri: mp.MapboxStyles.DARK,
            key: ValueKey("mapWidget"),
            onMapCreated: _onMapCreated,
            cameraOptions: mp.CameraOptions(
              zoom: 15,
              pitch: 55,
            ),
          ),
//          BottomMenuWidget(context)
        ]));
  }
}
