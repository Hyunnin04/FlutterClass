import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
// Import the theme

/// BlaButton is a reusable button widget that can be used in multiple places in the app
class BlaButton extends StatelessWidget {
  final String text; // The text that is displayed on the button
  final VoidCallback
      onPressed; // Callback function called when the button is pressed
  final bool isPrimary; // Button is a primary (default is true)
  final IconData icon;

  const BlaButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon,
          size: 20, color: isPrimary ? BlaColors.white : BlaColors.primary),
      label: Text(
        text,
        style: BlaTextStyles.button.copyWith(
          color: isPrimary ? BlaColors.white : BlaColors.primary,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(500, 48), // Height of the button (48dp)
        padding: const EdgeInsets.symmetric(
            horizontal: BlaSpacings.m), // Horizontal padding
        backgroundColor: isPrimary
            ? BlaColors.primary
            : BlaColors.white, // Button background
        foregroundColor:
            isPrimary ? BlaColors.white : BlaColors.primary, // Text color
        side: isPrimary
            ? null
            : BorderSide(
                color: BlaColors.disabled, width: 2), // Border for secondary
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(BlaSpacings.radiusLarge), // Rounded shape
        ),
      ),
    );
  }
}
