import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashServices{
  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    print(user);
    if (user != null){
      Timer(const Duration(seconds: 2),
        () => Navigator.pushNamed(context, 'home') 
      );
    }
    else{
      Timer(const Duration(seconds: 2), 
        () => Navigator.pushNamed(context, 'register')
      );
    }
  }
}