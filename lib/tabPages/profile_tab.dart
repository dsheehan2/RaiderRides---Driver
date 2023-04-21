import 'package:driver_app/global/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ProfileTabPage extends StatefulWidget
{

  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(width: 5, color: Colors.white),
              ),
              elevation: 20,
              color: const Color(0xFFcc0000),
              margin: const EdgeInsets.fromLTRB(30, 150, 30, 0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20,),

                    Text(
                      onlineDriverData.name!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "Mynerve",
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Rating: "+ titleStarRating,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "Mynerve",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Icon(
                          Icons.phone_android,
                          size: 30,
                        ),

                        const SizedBox(width: 5,),

                        Text(
                          onlineDriverData.phone!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Icon(
                          Icons.email_sharp,
                          size: 30,
                        ),

                        const SizedBox(width: 5,),

                        Text(
                          onlineDriverData.email!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30,),

            Image.asset(
              "images/texastechlogo.jpeg",
              scale: 5,
            ),

            const SizedBox(height: 30,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFcc0000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(width: 3, color: Colors.white,),
                ),
              ),
              onPressed: ()
              {
                fAuth.signOut();
                SystemNavigator.pop();
              },
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
