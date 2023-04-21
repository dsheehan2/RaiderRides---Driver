import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:driver_app/assistants/assistant_methods.dart';
import 'package:driver_app/global/global.dart';
import 'package:driver_app/mainScreens/new_trip_screen.dart';
import 'package:driver_app/models/user_ride_request_information.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationDialogBox extends StatefulWidget {
  UserRideRequestInformation? userRideRequestDetails;

  NotificationDialogBox({this.userRideRequestDetails});

  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular((24)),
      ),
      backgroundColor: Colors.transparent,
        elevation: 2,
        child: Container(
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[800],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const SizedBox(height: 14,),

              Image.asset(
                  "images/car_logo.png",
                width: 160,
              ),

              const SizedBox(height: 10,),

              // title
              const Text(
                "New Ride Request",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.grey
                ),
              ),

              const SizedBox(height: 12.0),

              // addresses origin destination
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // origin location with icon
                    Row(
                      children: [
                        Image.asset(
                            "images/origin.png",
                            width: 30,
                            height: 30,
                        ),
                        const SizedBox(width: 14,),
                        Expanded(
                          child: Container(
                            child: Text(
                              widget.userRideRequestDetails!.originAddress!,
                              style: const TextStyle(
                                fontSize: 16,
                                  color: Colors.grey
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 20.0,),

                    // destination location with icon
                    Row(
                      children: [
                        Image.asset(
                          "images/destination.png",
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 14,),
                        Expanded(
                          child: Container(
                            child: Text(
                              widget.userRideRequestDetails!.destinationAddress!,
                              style: const TextStyle(
                                fontSize: 16,
                                  color: Colors.grey
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // buttons cancel and accept
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        audioPlayer.pause();
                        audioPlayer.stop();
                        audioPlayer = AssetsAudioPlayer();

                        // accept the rideRequest
                        acceptRideRequest(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        "Accept".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),

                    const SizedBox(width: 25.0,),

                    ElevatedButton(
                      onPressed: (){
                        audioPlayer.pause();
                        audioPlayer.stop();
                        audioPlayer = AssetsAudioPlayer();

                        // cancel the rideRequest
                        FirebaseDatabase.instance.ref()
                            .child("All Ride Requests")
                            .child(widget.userRideRequestDetails!.rideRequestId!)
                            .remove().then((value)
                        {
                          FirebaseDatabase.instance.ref()
                              .child("drivers")
                              .child(currentFirebaseUser!.uid)
                              .child("newRideStatus")
                              .set("idle");
                        }).then((value)
                        {
                          FirebaseDatabase.instance.ref()
                              .child("drivers")
                              .child(currentFirebaseUser!.uid)
                              .child("tripsHistory")
                              .child(widget.userRideRequestDetails!.rideRequestId!)
                              .remove();
                        }).then((value)
                        {
                          Fluttertoast.showToast(msg: "Ride Request has been cancelled, successfully. Restart App Now.");
                        });

                        Future.delayed(const Duration(milliseconds: 2000), ()
                        {
                          SystemNavigator.pop();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(
                        "Cancel".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  acceptRideRequest(BuildContext context)
  {
    String getRideRequestId = "";
    FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("newRideStatus")
        .once()
        .then((snap)
    {
        if(snap.snapshot.value != null)
        {
          getRideRequestId = snap.snapshot.value.toString();
        }
        else
        {
          Fluttertoast.showToast(msg: "This ride request does not exists.");
        }

        if(getRideRequestId == widget.userRideRequestDetails!.rideRequestId)
        {
          FirebaseDatabase.instance.ref()
              .child("drivers")
              .child(currentFirebaseUser!.uid)
              .child("newRideStatus")
              .set("accepted");

          AssistantMethods.pauseLiveLocationUpdates();

          // trip started now -> send driver to newRideScreen
          Navigator.push(context, MaterialPageRoute(builder: (c) => NewTripScreen(
              userRideRequestDetails: widget.userRideRequestDetails
          )));
        }
        else
        {
          Fluttertoast.showToast(msg: "This ride request does not exist");
        }
    });
  }
}
