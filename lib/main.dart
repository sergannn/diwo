import 'package:flutter/material.dart';
import 'package:flutter_application_1/animated_widgets.dart';
import 'package:flutter_application_1/confirmationcode_screen.dart';
import 'package:flutter_application_1/image_store_screen.dart';
import 'package:flutter_application_1/login_screen.dart';
import 'package:flutter_application_1/map_from_loto.dart';
import 'package:flutter_application_1/map_screen.dart';
import 'package:flutter_application_1/map_screen_ser.dart';
import 'package:flutter_application_1/profile_screen.dart';
import 'package:flutter_application_1/registration_screen.dart';
import 'package:flutter_application_1/start_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'splash_screen.dart'; /*
import 'package:mappable_maps_mapkit/async.dart';
import 'package:mappable_maps_mapkit/directions.dart';
import 'package:mappable_maps_mapkit/image.dart';
import 'package:mappable_maps_mapkit/init.dart';
import 'package:mappable_maps_mapkit/mapkit.dart';
import 'package:mappable_maps_mapkit/mapkit_factory.dart';
import 'package:mappable_maps_mapkit/mappable_map.dart';
import 'package:mappable_maps_mapkit/model.dart';
import 'package:mappable_maps_mapkit/places.dart';
import 'package:mappable_maps_mapkit/road_events_layer_style_provider.dart';
import 'package:mappable_maps_mapkit/runtime.dart';
import 'package:mappable_maps_mapkit/search.dart';
import 'package:mappable_maps_mapkit/transport.dart';
import 'package:mappable_maps_mapkit/ui_view.dart';
import 'package:mappable_maps_mapkit/widgets.dart';*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*
  await init.initMapkit(
    apiKey: 'YOUR_API_KEY'
  );
*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        child: MaterialApp(
      title: 'Diwo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MapScreenS(), // const StartScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/profile': (context) => ProfileScreen(),
        '/map': (context) => const MapScreen(),
        '/MapBoxxample': (context) => MapBoxLocationExample(),
        '/login': (context) => const LoginScreen(),
        '/image_store': (context) => const ImageStoreScreen(),
        '/animated_widgets': (context) => const MapScreen(),
        '/confirmationcode': (context) => const ConfirmationCodeScreen(),
      },
    ));
  }
}
