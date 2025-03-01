import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class PassengerSelectionScreen extends StatefulWidget {
  final int initialSeats;

  const PassengerSelectionScreen({super.key, required this.initialSeats});

  @override
  State<PassengerSelectionScreen> createState() =>
      _PassengerSelectionScreenState();
}

class _PassengerSelectionScreenState extends State<PassengerSelectionScreen> {
  late int selectedSeats;

  @override
  void initState() {
    super.initState();
    selectedSeats = widget.initialSeats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BlaColors.white, // Set app bar background color
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: Icon(Icons.close, color: BlaColors.primary),
          onPressed: () => Navigator.pop(context), // Close without saving
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(BlaSpacings.l), // Adds spacing around content
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns text to the left
          children: [
            Text(
              "Number of seats to book",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: BlaColors.textNormal,
              ),
            ),
            const SizedBox(height: BlaSpacings.m), // Adds vertical spacing

            // Row for - button, count, and + button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: selectedSeats > 1
                        ? BlaColors.iconNormal
                        : BlaColors.disabled, // Disable if at min seats
                  ),
                  onPressed: () {
                    if (selectedSeats > 1) {
                      setState(() => selectedSeats--);
                    }
                  },
                ),
                Text(
                  "$selectedSeats",
                  style: BlaTextStyles.heading.copyWith(
                    color: BlaColors.textNormal,
                  ), // Style the count text
                ),
                IconButton(
                  icon:
                      Icon(Icons.add_circle_outline, color: BlaColors.primary),
                  onPressed: () {
                    if (selectedSeats < 10) {
                      setState(() => selectedSeats++);
                    }
                  },
                ),
              ],
            ),

            const Spacer(), // Pushes the button to the bottom

            Align(
              alignment: Alignment.bottomRight, // Moves button to bottom-right
              child: FloatingActionButton.small(
                // Small circular FAB
                backgroundColor: BlaColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BlaSpacings.radiusLarge),
                ),
                onPressed: () {
                  Navigator.pop(context, selectedSeats); // Return selectedSeats
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: BlaColors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
