import './vehicle.dart';

class VehicleRepository {
  List<Vehicle> vehicles = [];

  void addVehicle(Vehicle vehicle) {
    vehicles.add(vehicle);
  }

  void removeVehicle(int index) {
    vehicles.removeAt(index);
  }

  List<Vehicle> getAll() {
    return vehicles;
  }

  Vehicle? getByRegistrationNumber(String registrationNumber) {
    try {
      return vehicles.firstWhere(
        (vehicle) => vehicle.registreringsnummer == registrationNumber,
      );
    } catch (e) {
      return null;
    }
  }
}
