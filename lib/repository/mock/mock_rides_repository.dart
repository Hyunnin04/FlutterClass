import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/model/user/user.dart';
import 'package:week_3_blabla_project/repository/rides_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

class MockRidesRepository extends RidesRepository {
  List<Ride> rides = [
    Ride(
      departureLocation:
          Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 5, minute: 30),
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().copyWith(hour: 7, minute: 30),
      driver: User(
        firstName: "Kannika",
        lastName: "",
        email: "kannika@example.com",
        phone: "012345678",
        profilePicture: "",
        verifiedProfile: true,
      ),
      availableSeats: 2,
      pricePerSeat: 8,
      acceptPets: false,
    ),
    Ride(
      departureLocation:
          Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 20, minute: 0),
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().copyWith(hour: 22, minute: 0),
      driver: User(
        firstName: "Chaylim",
        lastName: "",
        email: "chaylim@example.com",
        phone: "012345679",
        profilePicture: "",
        verifiedProfile: true,
      ),
      availableSeats: 0,
      pricePerSeat: 10,
      acceptPets: false,
    ),
    Ride(
      departureLocation:
          Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 5, minute: 0),
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().copyWith(hour: 8, minute: 0),
      driver: User(
        firstName: "Mengtech",
        lastName: "",
        email: "mengtech@example.com",
        phone: "012345680",
        profilePicture: "",
        verifiedProfile: true,
      ),
      availableSeats: 1,
      pricePerSeat: 12,
      acceptPets: false,
    ),
    Ride(
      departureLocation:
          Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 20, minute: 0),
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().copyWith(hour: 22, minute: 0),
      driver: User(
        firstName: "Limhao",
        lastName: "",
        email: "limhao@example.com",
        phone: "012345681",
        profilePicture: "",
        verifiedProfile: true,
      ),
      availableSeats: 2,
      pricePerSeat: 14,
      acceptPets: true,
    ),
    Ride(
      departureLocation:
          Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 5, minute: 0),
      arrivalLocation: Location(name: "Siem Reap", country: Country.cambodia),
      arrivalDateTime: DateTime.now().copyWith(hour: 8, minute: 0),
      driver: User(
        firstName: "Sovanda",
        lastName: "",
        email: "sovanda@example.com",
        phone: "012345682",
        profilePicture: "",
        verifiedProfile: true,
      ),
      availableSeats: 1,
      pricePerSeat: 16,
      acceptPets: false,
    ),
  ];

  @override
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    return rides.where((ride) {
      if (filter != null && filter.acceptPets && !ride.acceptPets) {
        return false;
      }
      return true;
    }).toList();
  }
}
