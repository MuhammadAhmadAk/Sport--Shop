import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/core/views/Auth/login_screen.dart';
import 'package:shop_app/core/views/home_screen.dart';

import '../Repo/auth_repo.dart';
import '../Utils/sharedpref_helper.dart';
import '../models/usermodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? curUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    checkAuthentication();
    super.initState();
  }

  void checkAuthentication() async {
    bool isLoggedIn = await SharedPreferenceHelper.isLoggedIn();

    // Use Future.delayed instead of Timer.periodic
    Future.delayed(Duration(seconds: 3), () {
      if (isLoggedIn && curUser != null) {
        navigateToHomeScreen();
      } else {
        navigateToLogin();
      }
    });
  }

  void navigateToHomeScreen() async {
    UserModel? userModel = await AuthRepository.getUserbyId(curUser!.uid);
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              userModel: userModel!,
              curUser: curUser,
            ), // Replace with your home screen.
          ),
        );
      },
    );
  }

  void navigateToLogin() {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
          child: Center(
        child: Text(
          "Sport Shop",
          style: GoogleFonts.kanit(
              fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      )),
    );
  }
}
