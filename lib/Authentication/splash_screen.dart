import 'package:flutter/material.dart';
import 'splash_services.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices() ;

  @override
  void initState(){
    super.initState(); 
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Authenticating...", style: TextStyle(fontSize: 30),),
      ),
    );
  }
}