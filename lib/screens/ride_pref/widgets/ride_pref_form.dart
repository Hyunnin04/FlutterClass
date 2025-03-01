import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/screens/ride_pref/passenger_selection_screen.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/input_pref.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';
import 'package:week_3_blabla_project/widgets/inputs/location_selection.dart';

/// A Ride Preference Form is a view to select:
///   - A departure location
///   - An arrival location
///   - A date
///   - A number of seats
/// The form can be created with an existing RidePref (optional).
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------
  @override
  void initState() {
    super.initState();
    departure = widget
        .initRidePref?.departure; // Get initial departure location if available
    arrival = widget
        .initRidePref?.arrival; // Get initial arrival location if available
    departureDate = widget.initRidePref?.departureDate ??
        DateTime.now(); // Set default date to current date
    requestedSeats = widget.initRidePref?.requestedSeats ??
        1; // Default to 1 seat if not specified
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // 1. Function to select the departure date
  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: departureDate, // Show the current selected date
      firstDate: DateTime(2023), // Earliest selectable date
      lastDate: DateTime(2101), // Latest selectable date
    );
    if (pickedDate != null && pickedDate != departureDate) {
      setState(() {
        departureDate = pickedDate; // Update selected date
      });
    }
  }

  // 2. Navigate to passenger selection screen and get the selected number of seats
  void _navigateToPassengerSelection() async {
    final int? selectedSeats = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PassengerSelectionScreen(initialSeats: requestedSeats),
      ),
    );
    if (selectedSeats != null) {
      setState(() {
        requestedSeats = selectedSeats;
      });
    }
  }

  void _selectLocation(bool isDeparture) async {
    final Location? selectedLocation = await Navigator.push(
      context,
      AnimationUtils.createBottomToTopRoute(
        LocationPicker(
          onLocationSelected: (location) {
            setState(() {
              if (isDeparture) {
                departure = location; // Update departure location
              } else {
                arrival = location; // Update arrival location
              }
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  // Swap departure and arrival locations
  void switchLocations() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;
  bool isChecked = false;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Departure location input
        InputTile(
          icon: isChecked ? Icons.radio_button_checked : Icons.radio_button_off,
          title: departure?.name ??
              "Leaving from", // Show departure location or default text
          trailingIcon: Icons.swap_vert,
          onPressed: switchLocations, // Swap locations when clicked
          onTap: () => _selectLocation(true),
        ),
        const BlaDivider(), // Divider between inputs
        InputTile(
          icon: Icons.radio_button_off,
          title: arrival?.name ??
              "Going to", // Show arrival location or default text
          onTap: () => _selectLocation(false), // Select arrival location
          trailingIcon: null,
        ),
        const BlaDivider(),
        InputTile(
          icon: Icons.date_range,
          title: DateFormat.yMMMd().format(departureDate),
          onTap: selectDate,
          trailingIcon: null,
        ),
        const BlaDivider(),
        InputTile(
          icon: Icons.person_outline,
          title: "$requestedSeats",
          onTap: _navigateToPassengerSelection,
          trailingIcon: null,
        ),
        Padding(
          padding: const EdgeInsets.all(BlaSpacings.m),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: (departure != null && arrival != null)
                  ? BlaColors.primary
                  : BlaColors.greyLight,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            onPressed: (departure != null && arrival != null)
                ? () {
                    final currentPref = RidePref(
                      departure: departure!,
                      arrival: arrival!,
                      departureDate: departureDate,
                      requestedSeats: requestedSeats,
                    );
                  }
                : null,
            child: Text(
              'Search',
              style: BlaTextStyles.button.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
