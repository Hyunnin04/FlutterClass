import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/locations_repository.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  // static const List<Location> availableLocations = fakeLocations;

  //1 - Singleton pattern
  static LocationsService? _instance;

  //2 - Repository to get the data
  final LocationRepository repository;

  //3 - Private constructor to initialize the repository
  LocationsService._internal(this.repository) {}

  //4 - Initialize the service with the repository
  static void initialize(LocationRepository repository) {
    _instance = LocationsService._internal(repository);
  }

  //5 - Get the instance of the service
  static LocationsService get instance {
    if (_instance == null) {
      throw Exception(
          "The service is not ititialized Please run intialize first");
    }
    return _instance!;
  }

  //6 - Get the list of locations
  List<Location> getLocations() {
    return repository.getLocations();
  }
}
