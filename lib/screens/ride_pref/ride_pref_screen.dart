import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/ride_pref_form.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/ride_pref_history_tile.dart';

import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_prefs_service.dart';
import '../../theme/theme.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preference and launch a search on it
class RidePrefScreen extends StatefulWidget {
  const RidePrefScreen({super.key});

  @override
  State<RidePrefScreen> createState() => _RidePrefScreenState();
}

class _RidePrefScreenState extends State<RidePrefScreen> {
  RidePref? selectedRidePref; // Store selected ride preference

  /// When a ride preference is selected from history,
  /// update the form with its data.
  void onRidePrefSelected(RidePref ridePref) {
    setState(() {
      selectedRidePref = ridePref; // Update selected preference
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1 - Background Image
        BlaBackground(),

        // 2 - Foreground content
        SingleChildScrollView(
          // Wrap the content in a scrollable view
          child: Column(
            children: [
              SizedBox(height: 16),
              Text(
                "Your pick of rides at low price",
                style: BlaTextStyles.heading.copyWith(color: Colors.white),
              ),
              SizedBox(height: 100),
              Container(
                margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
                decoration: BoxDecoration(
                  color: Colors.white, // White background
                  borderRadius: BorderRadius.circular(16), // Rounded corners
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 2.1 Display the Form to input the ride preferences
                    RidePrefForm(initRidePref: selectedRidePref),
                    SizedBox(height: BlaSpacings.m),

                    // 2.2 Optionally display a list of past preferences
                    SizedBox(
                      height: 200, // Set a fixed height
                      child: ListView.builder(
                        shrinkWrap: true, // Fix ListView height issue
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: RidePrefService.ridePrefsHistory.length,
                        itemBuilder: (ctx, index) => RidePrefHistoryTile(
                          ridePref: RidePrefService.ridePrefsHistory[index],
                          onPressed: () => onRidePrefSelected(
                              RidePrefService.ridePrefsHistory[index]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Background Image Widget
class BlaBackground extends StatelessWidget {
  const BlaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}
