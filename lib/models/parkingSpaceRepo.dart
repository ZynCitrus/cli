import './parkingSpace.dart';

class ParkingSpaceRepository {
  List<ParkingSpace> parkingSpaces = [
    ParkingSpace(
        id: 1, adress: "123 Main Street, New York, NY 10001", perHour: 15),
    ParkingSpace(
        id: 2, adress: "456 Park Avenue, New York, NY 10022", perHour: 25),
    ParkingSpace(
        id: 3, adress: "789 Broadway, New York, NY 10003", perHour: 20),
    ParkingSpace(
        id: 4, adress: "321 5th Avenue, New York, NY 10016", perHour: 18),
    ParkingSpace(
        id: 5, adress: "654 Madison Avenue, New York, NY 10065", perHour: 30),
  ];
  void addParkingSpace(ParkingSpace parkingSpace) {
    parkingSpaces.add(parkingSpace);
  }

  void removeParkingSpace(int index) {
    parkingSpaces.removeAt(index);
  }

  List<ParkingSpace> getAll() {
    return parkingSpaces;
  }

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
