import './parking.dart';

class ParkingRepository {
  List<Parking> parkings = [];

  void addParking(Parking parking) {
    parkings.add(parking);
  }

  void removeParking(int index) {
    parkings.removeAt(index);
  }

  List<Parking> getAll() {
    return parkings;
  }

  Parking? getById(int id) {
    try {
      return parkings.firstWhere(
        (parking) => parking.fordon.registreringsnummer == id,
      );
    } catch (e) {
      return null;
    }
  }
}
