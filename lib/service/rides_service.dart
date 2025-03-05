import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/rides_repository.dart';

import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  // static List<Ride> availableRides = fakeRides;

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  static RidesService? _instance;
  final RidesRepository repository;

  RidesService._internal(this.repository);

  static void initialize(RidesRepository repository) {
    _instance = RidesService._internal(repository);
  }

  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
          "The service is not initialized. Please run initialize first.");
    }
    return _instance!;
  }

  static List<Ride> getRides(RidePreference preferences,
      {RidesFilter? filter}) {
    // For now, just a test
    return _instance!.repository
        .getRides(preferences, filter)
        .where((ride) =>
            ride.departureLocation == preferences.departure &&
            ride.arrivalLocation == preferences.arrival)
        .toList();
  }
}

/// A class for searching rides.
class RidesFilter {
  // Whether the ride should accept pets or not.
  bool acceptPets;
  RidesFilter(
      {required this.acceptPets}); // Constructor to initialize the filter.
}
