import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sih_sos/MongoDB/databaseConnection.dart';
import 'Authentication/register.dart';
import 'Authentication/otp.dart';
import 'homepage.dart';
import 'firebase_options.dart';
import 'Authentication/splash_screen.dart';
import 'test.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 133, 140, 233)),
        useMaterial3: true,
      ),
      routes: {
        'test' : (context) => Test(),
        'splash':(context) => const SplashScreen(),
        'register' : (context) => const Register(),
        'otp' :(context) => const Otp(),
        'home' :(context) => const HomePage(title: "Saviors of Society"),
      },);
  }

}


