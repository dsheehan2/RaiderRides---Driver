import 'package:driver_app/mainScreens/trips_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../infoHandler/app_info.dart';

class EarningsTabPage extends StatefulWidget {
  const EarningsTabPage({Key? key}) : super(key: key);

  @override
  State<EarningsTabPage> createState() => _EarningsTabPageState();
}

class _EarningsTabPageState extends State<EarningsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          //earnings
          Container(
        color: Colors.black,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: Column(
                children: [
                  const Text(
                    "Your Earnings",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "\$" + Provider.of<AppInfo>(context, listen: false).driverTotalEarnings,
                    style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            )
    ),

          //total number of trips the driver has completed
          ElevatedButton(
              onPressed:()
              {
                Navigator.push(context, MaterialPageRoute(builder: (c)=> TripsHistoryScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  children: [

                    Image.asset(
                      'images/car_logo.png',
                      width: 100,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    const Text(
                      "Trips Completed",
                      style: TextStyle(
                        color: Colors.black,
                      )
                    ),

                    Expanded(
                      child: Container(
                        child: Text(
                          Provider.of<AppInfo>(context, listen: false).allTripHistoryInfoList.length.toString(),
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ]
    ),
    );
  }
}
