import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/trips_history_model.dart';

class HistoryDesignUIWidget extends StatefulWidget
{
  TripHistoryModel? tripHistoryModel;

  HistoryDesignUIWidget({this.tripHistoryModel});

  @override
  State<HistoryDesignUIWidget> createState() => _HistoryDesignUIWidgetState();
}

class _HistoryDesignUIWidgetState extends State<HistoryDesignUIWidget>
{
  String formatDateAndTime(String dateTimeFromDB)
  {
    DateTime dateTime = DateTime.parse(dateTimeFromDB);
    
    String formattedDateTime = "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDateTime;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // driver name + fare amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    "User: ${widget.tripHistoryModel!.userName!}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 12,),

                Text(
                  "\$ ${widget.tripHistoryModel!.fareAmount!}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 2,),

            // car details
            // Row(
            //   children: [
            //     const Icon(
            //       Icons.car_repair,
            //       color: Colors.black,
            //       size: 28,
            //     ),
            //
            //
            //     const SizedBox(width: 12,),
            //
            //     Text(
            //       widget.tripHistoryModel!.user!,
            //       style: const TextStyle(
            //         fontSize: 16,
            //         color: Colors.grey,
            //         fontWeight: FontWeight.w700,
            //       ),
            //     ),
            //   ],
            // ),

            const SizedBox(height: 20,),

            // pickup address and icon
            Row(
              children: [
                Image.asset(
                  "images/origin.png",
                  height: 20,
                  width: 20,
                ),

                const SizedBox(width: 12,),

                Expanded(
                  child: Container(
                    child: Text(
                      widget.tripHistoryModel!.originAddress!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14,),

            // dropoff address and icon
            Row(
              children: [
                Image.asset(
                  "images/destination.png",
                  height: 24,
                  width: 24,
                ),

                const SizedBox(width: 12,),

                Expanded(
                  child: Container(
                    child: Text(
                      widget.tripHistoryModel!.destinationAddress!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // trip time and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(""),
                Text(
                  formatDateAndTime(widget.tripHistoryModel!.time!),
                  style: const TextStyle(
                  color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 2,),

          ],
        ),
      ),
    );
  }
}
