import './parkingSpace.dart';

class ParkingSpaceRepository {
  List<ParkingSpace> parkingSpaces = [];

  // Lägg till en parkeringsplats
  void addParkingSpace(ParkingSpace parkingSpace) {
    parkingSpaces.add(parkingSpace);
  }

  // Ta bort en parkeringsplats baserat på index
  void removeParkingSpace(int index) {
    parkingSpaces.removeAt(index);
  }

  // Hämta alla parkeringsplatser
  List<ParkingSpace> getAll() {
    return parkingSpaces;
  }

  // Hämta parkeringsplats baserat på id
  ParkingSpace? getById(int id) {
    try {
      return parkingSpaces.firstWhere(
        (space) => space.id == id,
      );
    } catch (e) {
      return null;
    }
  }
}
