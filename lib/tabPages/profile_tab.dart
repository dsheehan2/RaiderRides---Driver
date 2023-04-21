import 'package:flutter/material.dart';

import '../global/global.dart';
import '../splashScreen/splash_screen.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
          child: Text(
            "Sign Out"
          ),
          onPressed: ()
            {
              fAuth.signOut(); //making null
              Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
            }
        ),
    );
  }
}
