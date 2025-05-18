import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth_screens/login_screen_auth.dart';
import 'package:flutter_application_1/screens/game_screens/collections/collections_diwo_screen.dart';
import 'package:flutter_application_1/screens/game_screens/collections/collections_puzzle_screen.dart';
import 'package:flutter_application_1/screens/game_screens/rating/rating_screen.dart';
import 'package:flutter_application_1/screens/auth_screens/confirmationcode_screen.dart';
import 'package:flutter_application_1/screens/game_screens/settings/settings_screen.dart';
import 'package:flutter_application_1/screens/auth_screens/login_screen.dart';
import 'package:flutter_application_1/screens/game_screens/map/map_screen.dart';
import 'package:flutter_application_1/screens/game_screens/profile/profile_screen.dart';
import 'package:flutter_application_1/screens/auth_screens/registration_screen.dart';
import 'package:flutter_application_1/utils/timer/timer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
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
  var theTimer = CountdownTimer(initialSeconds: 6 * 3600); // 6 hours
  theTimer.startTimer();
  runApp(ChangeNotifierProvider(
      create: (context) => theTimer,
      child: MyApp(
        isLoggedIn: isLoggedIn,
        pass: pass,
        phone: phone,
      )));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? phone;
  final String? pass;
  const MyApp({super.key, required this.isLoggedIn, this.pass, this.phone});

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
      home: isLoggedIn
          ? LoginScreenAuth(pass: pass ?? '', phone: phone ?? '')
          : const SplashScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/registration': (context) => const RegistrationScreen(),
        //  '/profile': (context) => ProfileScreen(),
        // '/map': (context) => const MapScreen(),
        '/profileScreenSer': (context) => ProfileScreenSer(),
        '/MapBoxExample': (context) => MapBoxLocationExample(),
        '/login': (context) => const LoginScreen(),
        //   '/image_store': (context) => const ImageStoreScreen(),
        // '/animated_widgets': (context) => const MapScreen(),
        '/confirmationcode': (context) => const ConfirmationCodeScreen(),
        '/rating': (context) => const RatingScreenSer(),
        '/settings': (context) => const SettingsScreenSer(),
        '/collectionsD': (context) => const CollectionsDiwoScreen(),
        '/collectionsP': (context) => const CollectionsPuzzleScreen(),
      },
      onGenerateRoute: (settings) {},
    ));
  }
}
