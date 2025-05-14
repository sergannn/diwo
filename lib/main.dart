import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/game_screens/collections_diwo_screen.dart';
import 'package:flutter_application_1/screens/game_screens/rating_screen.dart';
import 'package:flutter_application_1/screens/auth_screens/confirmationcode_screen.dart';
import 'package:flutter_application_1/screens/game_screens/settings_screen.dart';
import 'package:flutter_application_1/tmp/image_store_screen.dart';
import 'package:flutter_application_1/screens/game_screens/login_screen.dart';
import 'package:flutter_application_1/screens/game_screens/map_screen.dart';
import 'package:flutter_application_1/screens/game_screens/profile_screen.dart';
import 'package:flutter_application_1/tmp/profile_screen.dart';
import 'package:flutter_application_1/screens/auth_screens/registration_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'screens/start_screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = FlutterSecureStorage();

  var pass = await storage.read(key: 'pass');
  var phone = await storage.read(key: 'phone');

/*
  await init.initMapkit(
    apiKey: 'YOUR_API_KEY'
  );
*/
  final isLoggedIn = pass != null && phone != null;
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message?.contains('updateAcquireFence') == false) {
      debugPrintSynchronously(message!, wrapWidth: wrapWidth);
    }
  };
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diwo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: isLoggedIn ? MapBoxLocationExample() : const SplashScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/profile': (context) => ProfileScreen(),
        // '/map': (context) => const MapScreen(),
        '/profileScreenSer': (context) => ProfileScreenSer(),
        '/MapBoxExample': (context) => MapBoxLocationExample(),
        '/login': (context) => const LoginScreen(),
        '/image_store': (context) => const ImageStoreScreen(),
        // '/animated_widgets': (context) => const MapScreen(),
        '/confirmationcode': (context) => const ConfirmationCodeScreen(),
        '/rating': (context) => const RatingScreenSer(),
        '/settings': (context) => const SettingsScreenSer(),
        '/collectionsD': (context) => const CollectionsDiwoScreen(),
      },
    ));
  }
}
