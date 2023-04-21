import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:driver_app/global/global.dart';
import 'package:driver_app/models/user_ride_request_information.dart';
import 'package:driver_app/push_notifications/notification_dialog_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PushNotificationSystem
{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging(BuildContext context) async
  {
    //1. Terminated
    // (When app is completely closed and opened directly from push notification)
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage)
    {
      if(remoteMessage != null)
        {
          // display ride request info - user info who request a ride
          readUserRideRequestInformation(remoteMessage.data["rideRequestId"], context);
        }
    });

    //2. Foreground
    //(When app is open and it receives a push notifications)
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage)
    {
      //display ride request information - user information who request a ride
      readUserRideRequestInformation(remoteMessage!.data["rideRequestId"], context);
    });

    //3. Background
    // (When app is in background and opened directly from push notifications)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage)
    {
      //display ride request information - user information who request a ride
      readUserRideRequestInformation(remoteMessage!.data["rideRequestId"], context);
    });
  }

  readUserRideRequestInformation(String userRideRequestId, BuildContext context)
  {
    FirebaseDatabase.instance.ref()
        .child("All Ride Requests")
        .child(userRideRequestId)
        .once()
        .then((snapData)
    {
      if(snapData.snapshot.value != null)
      {
        audioPlayer.open(Audio("music/music_notification.mp3"));
        audioPlayer.play();

        double originLat = double.parse((snapData.snapshot.value! as Map)["origin"]["latitude"]);
        double originLng = double.parse((snapData.snapshot.value! as Map)["origin"]["longitude"]);
        String originAddress = (snapData.snapshot.value! as Map)["originAddress"];

        double destinationLat = double.parse((snapData.snapshot.value! as Map)["destination"]["latitude"]);
        double destinationLng = double.parse((snapData.snapshot.value! as Map)["destination"]["longitude"]);
        String destinationAddress = (snapData.snapshot.value! as Map)["destinationAddress"];

        String userName = (snapData.snapshot.value! as Map)["userName"];
        String userPhone = (snapData.snapshot.value! as Map)["userPhone"];

        String? rideRequestId = snapData.snapshot.key;
        print(rideRequestId);

        UserRideRequestInformation userRideRequestDetails = UserRideRequestInformation();

        userRideRequestDetails.originLatLng = LatLng(originLat, originLng);
        userRideRequestDetails.originAddress = originAddress;

        userRideRequestDetails.destinationLatLng = LatLng(destinationLat, destinationLng);
        userRideRequestDetails.destinationAddress = destinationAddress;

        userRideRequestDetails.userName = userName;
        userRideRequestDetails.userPhone = userPhone;

        userRideRequestDetails.rideRequestId = rideRequestId;

        showDialog(
          context: context,
          builder: (BuildContext context) => NotificationDialogBox(
              userRideRequestDetails: userRideRequestDetails,
          ),
        );
      }
      else
      {
        Fluttertoast.showToast(msg: "This Ride Request Id does not exist");
      }
    });
  }

  Future generateAndGetToken() async
  {
    String? registrationToken = await messaging.getToken();

    FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("token")
        .set(registrationToken);

    messaging.subscribeToTopic("allDrivers");
    messaging.subscribeToTopic("allUsers");


  }
}