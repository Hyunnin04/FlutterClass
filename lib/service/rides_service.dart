import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/rides_repository.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///

/// A service class for handling rides.
class RidesService {
  static RidesService? _instance;
  final RidesRepository repository;

  // Constructor for the service.
  RidesService._internal(this.repository);

  // Initialize the service with a repository.
  static void initialize(RidesRepository repository) {
    _instance = RidesService._internal(repository);
  }

  // Get the instance of the service.
  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
          "The service is not initialized. Please run initialize first.");
    }
    return _instance!;
  }

  // Get the list of rides based on the preferences.
  List<Ride> getRides(RidePreference preferences,
      {RidesFilter? filter, RideSortType? sortType}) {

      // 1 - Filter the rides based on the preferences
      var rides =_instance!.repository.getRides(preferences, filter).where((ride) {

      // 2 - Ensure departure and arrival locations match
      bool locationMatch = ride.departureLocation.name == preferences.departure.name && // Check if the departure location matches the preference.
          ride.arrivalLocation.name == preferences.arrival.name; // Check if the arrival location matches the preference.

      // 3 - Ensure departure date matches (same day comparison)
      bool dateMatch = ride.departureDate.year == preferences.departureDate.year && // Check if the year matches the preference.
          ride.departureDate.month == preferences.departureDate.month && // Check if the month matches the preference.
          ride.departureDate.day == preferences.departureDate.day; // Check if the day matches the preference.

      // 4 - Ensure enough available seats
      bool seatAvailability = ride.availableSeats >= preferences.requestedSeats; // Check if there are enough available seats.

      return locationMatch && dateMatch && seatAvailability; // Return the ride if all conditions are met.
    }).toList();

    // 5 - Apply sorting based on the requested criteria
    if (sortType != null) {
      rides.sort((a, b) {
        switch (sortType) {
          case RideSortType.departureTime:
            return a.departureDate.compareTo(b.departureDate); // Earliest first
          case RideSortType.availableSeats:
            return b.availableSeats
                .compareTo(a.availableSeats); // Most seats first
          case RideSortType.price:
            return (a.pricePerSeat ?? double.infinity)
                .compareTo(b.pricePerSeat ?? double.infinity); // Cheapest first
        }
      });
    }

    return rides;
  }
}

/// A class for searching rides.
class RidesFilter {
  // Whether the ride should accept pets or not.
  bool acceptPets;
  RidesFilter({required this.acceptPets}); // Constructor to initialize the filter.
}

/// Sorting options for rides
enum RideSortType { departureTime, availableSeats, price }
