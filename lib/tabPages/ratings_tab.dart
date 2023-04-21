import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../infoHandler/app_info.dart';


class RatingsTabPage extends StatefulWidget
{
  const RatingsTabPage({Key? key}) : super(key: key);

  @override
  State<RatingsTabPage> createState() => _RatingsTabPageState();
}

class _RatingsTabPageState extends State<RatingsTabPage> {

  double ratingsNumber = 0;
  String titleStarRating = "Good";

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

    getRatingsNumber();

  }

  getRatingsNumber()
  {
    setState(() {
      ratingsNumber = double.parse(Provider.of<AppInfo>(context, listen: false).driverAverageRatings);
    });

    setupRatingsTitle();
  }

  setupRatingsTitle()
  {
    if(ratingsNumber == 1)
    {
      setState(() {
        titleStarRating = "Very Bad";
      });
    }

    if(ratingsNumber == 2)
    {
      setState(() {
        titleStarRating = "Bad";
      });
    }

    if(ratingsNumber == 3)
    {
      setState(() {
        titleStarRating = "Normal";
      });
    }

    if(ratingsNumber == 4)
    {
      setState(() {
        titleStarRating = "Good";
      });
    }

    if(ratingsNumber == 5)
    {
      setState(() {
        titleStarRating = "Very Good";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: Colors.white60,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 22,),
              const Text(
                "Your Ratings:",
                style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54
                ),
              ),

              const SizedBox(height: 22,),

              const Divider(
                height: 4.0,
                thickness: 4.0,
              ),

              const SizedBox(height: 22,),

              SmoothStarRating(
                rating: ratingsNumber,
                allowHalfRating: true,
                starCount: 5,
                size: 46,
              ),

              const SizedBox(height: 12,),

              Text(
                titleStarRating,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 18,),
            ],
          ),
        ),
      ),
    );
  }
}
