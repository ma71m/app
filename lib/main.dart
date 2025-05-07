import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_dialogs/flutter_easy_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:sahla/screens/splash_screen.dart';
import 'package:sahla/services/providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class FirebaseConfig {
  static FirebaseOptions options = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY'] ?? '',
    appId: '1:44167858461:android:a21ecfccabf9aa3af639f4',
    messagingSenderId: '44167858461',
    projectId: 'sahla-3ndna',
  );
}

void main() async {
  await dotenv.load(fileName: "secure.env");
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: FirebaseConfig.options);
    print('Firebase initialized successfully §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§');
  } catch (e) {
    print('Error initializing Firebase: $e  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§');
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DealProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

MaterialColor customSwatch = const MaterialColor(
  0xFFFF8F00,
  {
    50: Color.fromRGBO(255, 143, 0, .1),
    100: Color.fromRGBO(255, 143, 0, .2),
    200: Color.fromRGBO(255, 143, 0, .3),
    300: Color.fromRGBO(255, 143, 0, .4),
    400: Color.fromRGBO(255, 143, 0, .5),
    500: Color.fromRGBO(255, 143, 0, .6),
    600: Color.fromRGBO(255, 143, 0, .7),
    700: Color.fromRGBO(255, 143, 0, .8),
    800: Color.fromRGBO(255, 143, 0, .9),
    900: Color.fromRGBO(255, 143, 0, 1),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,builder: FlutterEasyDialogs.builder(),
      debugShowCheckedModeBanner: false,
      title: 'SAHLA',
      theme: ThemeData(
        primarySwatch: customSwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}
