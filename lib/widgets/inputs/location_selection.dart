import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';
import 'package:week_3_blabla_project/widgets/inputs/location_tile.dart';
import '../../../model/ride/locations.dart';

//
// Location Picker Screen
//
class LocationPicker extends StatefulWidget {
  final Function(Location)
      onLocationSelected; // Callback when location is selected

  const LocationPicker({super.key, required this.onLocationSelected});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  // Search controller to manage text input
  final TextEditingController _searchController = TextEditingController();

  // List to hold filtered search results
  List<Location> _filteredLocations = [];

  // Flag to track initial empty state
  bool _showInitialState = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Back button to close the modal
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),

        // Search input field
        title: TextField(
          controller: _searchController,
          autofocus: true, // Auto-focus keyboard on open
          decoration: InputDecoration(
            hintText: 'Search city or country',
            border: InputBorder.none, // Remove default underlines
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    // Clear search button
                    icon: const Icon(Icons.clear),
                    onPressed: _clearSearch,
                  )
                : null,
          ),
          onChanged: (query) {
            setState(() => _showInitialState = query.isEmpty);
            _filterLocations(query); // Update results as user types
          },
        ),
      ),
      // Dynamic body content based on search state
      body: _buildBodyContent(),
    );
  }

  Widget _buildBodyContent() {
    // Initial state - show prompt message
    if (_showInitialState) {
      return const Center(
        child: Text(
          'Start typing to search locations',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    // No results state
    if (_filteredLocations.isEmpty) {
      return const Center(
        child: Text(
          'No locations found',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    // Results list - show matching locations
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _filteredLocations.length,
      separatorBuilder: (_, __) => BlaDivider(),
      itemBuilder: (context, index) => LocationTile(
        location: _filteredLocations[index],
        onTap: () => widget.onLocationSelected(_filteredLocations[index]),
        // Selection handler
      ),
    );
  }

  // ---------------------------
  // SEARCH FUNCTIONALITY
  // ---------------------------
  void _filterLocations(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredLocations = []; // Clear results when search is empty
      } else {
        // Filter locations by name or country
        _filteredLocations = fakeLocations.where((loc) {
          final nameMatch =
              loc.name.toLowerCase().contains(query.toLowerCase());
          final countryMatch =
              loc.country.name.toLowerCase().contains(query.toLowerCase());
          return nameMatch || countryMatch;
        }).toList();
      }
    });
  }

  // Clear search input and reset states
  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _filteredLocations = [];
      _showInitialState = true;
    });
  }
}
