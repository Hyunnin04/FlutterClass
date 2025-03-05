import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/locations_repository.dart';

///
/// This class is a mock repository to provide a list of locations
///
class MockLocationsRepository extends LocationRepository {
  final List<Location> Khmerlocation = [
    Location(name: "Phnom Penh", country: Country.cambodia),
    Location(name: "Siem Reap", country: Country.cambodia),
    Location(name: "Battambang", country: Country.cambodia),
    Location(name: "Sihanouk Ville", country: Country.cambodia),
    Location(name: "Kampot", country: Country.cambodia),
  ];

  ///
  /// This method returns the list of locations
  ///
  @override
  List<Location> getLocations() {
    return Khmerlocation;
  }
}
