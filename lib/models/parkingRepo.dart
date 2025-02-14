import './parking.dart';

class ParkingRepository {
  List<Parking> parkings = [];

  void addParking(Parking parking) {
    parkings.add(parking);
  }

  void removeParking(int index) {
    if (index >= 0 && index < parkings.length) {
      parkings.removeAt(index);
    }
  }

  List<Parking> getAll() {
    return parkings;
  }

  Parking? getByVehicleReg(String regNumber) {
    try {
      return parkings.firstWhere(
        (parking) => parking.fordon.registreringsnummer == regNumber,
      );
    } catch (e) {
      return null;
    }
  }
}
