import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

//
// Location Tile for supporting the displaying of the Location
//
class LocationTile extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;

  const LocationTile({super.key, required this.location, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Location tile
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: const Icon(Icons.location_on_outlined, size: 28),
      title: Text(location.name, style: BlaTextStyles.body),
      subtitle: Text(
        location.country.name,
        style: BlaTextStyles.label,
      ),
      onTap: onTap,
    );
  }
}
