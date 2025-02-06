import './vehicle.dart';

class VehicleRepository {
  List<Vehicle> vehicles = [];

  // Lägg till ett fordon
  void addVehicle(Vehicle vehicle) {
    vehicles.add(vehicle);
  }

  // Ta bort ett fordon baserat på index
  void removeVehicle(int index) {
    vehicles.removeAt(index);
  }

  // Hämta alla fordon
  List<Vehicle> getAll() {
    return vehicles;
  }

  // Hämta ett fordon baserat på registreringsnummer
  Vehicle? getByRegistrationNumber(int registrationNumber) {
    try {
      return vehicles.firstWhere(
        (vehicle) => vehicle.registreringsnummer == registrationNumber,
      );
    } catch (e) {
      return null;
    }
  }
}
