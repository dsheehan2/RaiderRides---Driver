import 'dart:async';

import 'package:driver_app/authentication/login_screen.dart';
import 'package:driver_app/authentication/signup_screen.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';
import '../mainScreens/main_screen.dart';

class MySplashScreen extends StatefulWidget
{
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen>
{
  startTimer()
  {
    Timer(const Duration(seconds: 3), ()
    {
      if(fAuth.currentUser != null)
      {
        currentFirebaseUser = fAuth.currentUser; // Remembers new instance when reopening app.
        Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

  @override
  void initState()
  {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context)
  {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset("images/texastechlogo.jpeg"),

              const SizedBox(height: 20,),

              const Text(
                "Raider Rides",
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'Mynerve',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          )
        ),
      ),
    );
  }
}
