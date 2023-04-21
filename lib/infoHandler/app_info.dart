import 'package:flutter/material.dart';

import '../models/directions.dart';
import '../models/trips_history_model.dart';


class AppInfo extends ChangeNotifier
{
  Directions? userPickUpLocation, userDropOffLocation;
  int countTotalTrips = 0;
  String driverTotalEarnings = "0";
  String driverAverageRatings = "0";
  List<String> historyTripKey = [];
  List<TripHistoryModel> allTripHistoryInfoList = [];

  void updatePickupLocationAddress(Directions userPickUpAddress)
  {
    userPickUpLocation = userPickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Directions dropOffAddress)
  {
    userDropOffLocation = dropOffAddress;
    notifyListeners();
  }

  updateOverallTripCounter(int tripCounter)
  {
    countTotalTrips = tripCounter;
    notifyListeners();
  }

  updateOverallTripKey(List<String> tripKeyList)
  {
    historyTripKey = tripKeyList;
    notifyListeners();
  }

  updateOverallTripHistoryInfo(TripHistoryModel eachTripHistory)
  {
    allTripHistoryInfoList.add(eachTripHistory);
    notifyListeners();
  }

  updateDriverTotalEarnings(String driverEarnings)
  {
     driverTotalEarnings = driverEarnings;
  }

  updateDriverAverageRatings(String driverRatings)
  {
    driverAverageRatings = driverRatings;
  }
}