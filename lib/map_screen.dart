import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:yandex_maps_mapkit/yandex_map.dart';
//import 'package:yandex_maps_mapkit/yandex_maps_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late YandexMapController _mapController;
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
      
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isMenuOpen ? MediaQuery.of(context).size.width * 0.8 : 0,
            height: double.infinity,
            color: Colors.grey[800],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 60),
                      Text(
                        'Меню',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isMenuOpen = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blue.shade200,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.blue.shade200,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Иван',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '0 followers | 84 following',
                            style: GoogleFonts.roboto(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(
                        icon: Icons.collections,
                        text: 'Коллекция',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CollectionScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildButton(
                        icon: Icons.photo_library,
                        text: 'Каталог картинок',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ImageCatalogScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            top: 16,
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isMenuOpen = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _customizeMapStyle() async {
    final mapKit = MapKitFactory.getInstance();
    
    final mapStyleBuilder = MapStyleBuilder()
      ..isNightModeEnabled = true
      ..setBuildingColor(const Color.fromRGBO(64, 64, 64, 1.0))
      ..setWaterColor(const Color.fromRGBO(0, 68, 68, 1.0))
      ..setRoadStrokeColor(Colors.white);
    
    await mapKit.mapStyleManager.setMapStyle(mapStyleBuilder.build());
  }
/*
  void _onUserLocationAdded(UserLocation location) {
    _mapController.move(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          tilt: location.point,
          zoom: 15.0, azimuth: null, tilt: null,
        ),
      ),
      animation: MapAnimation.smooth,
    );
  }*/

  Widget _buildButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapAnimation {
  // ignore: prefer_typing_uninitialized_variables
  static var smooth;
}

class CameraUpdate {
  static newCameraPosition(cameraPosition) {}
}

class UserLocation {
  get point => null;
}

class MapStyleBuilder {
  set isNightModeEnabled(bool isNightModeEnabled) {}
  
  setBuildingColor(Color color) {}
  
  setWaterColor(Color color) {}
  
  setRoadStrokeColor(Color white) {}
  
  build() {}
}

class MapKitFactory {
  static getInstance() {}
}

class YandexMapController {
  void move(newCameraPosition, {required animation}) {}
}

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
    ],
  ),
),
      appBar: AppBar(
        title: const Text('Коллекция'),
      ),
      body: const Center(
        child: Text('Содержимое коллекции'),
      ),
    );
  }
}

class ImageCatalogScreen extends StatelessWidget {
  const ImageCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог картинок'),
      ),
      body: const Center(
        child: Text('Содержимое каталога'),
      ),
    );
  }
}