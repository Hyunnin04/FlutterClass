import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';

/// A widget that displays information about a specific trip.

///   - Departure and arrival locations to indicate the route.
///   - Departure and arrival times to inform the user of the schedule.
///   - A visually distinct card layout with padding and elevation for better UI.
///

class RideCard extends StatelessWidget {
  final Ride ride;
  const RideCard({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 3, // Provides a shadow effect to create a sense of depth in UI
      child: Padding(
        padding: EdgeInsets.all(
            8), // Adds margin around the card for spacing between elements
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displays departure and arrival locations in a readable format
            Text(
              "Departure: ${ride.departureLocation.name} => Arrival: ${ride.arrivalLocation.name}", // applies predefind text style for consistency
              style: BlaTextStyles.body,
            ),
            SizedBox(height: 8),

            // Displays formatted departure and arrival times
            Text(
                "Time: ${DateTimeUtils.formatTime(ride.departureDate)} => ${DateTimeUtils.formatTime(ride.arrivalDateTime)}",
                style: BlaTextStyles.body),
          ],
        ),
      ),
    );
  }
}
