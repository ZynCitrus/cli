import './vehicle.dart';
import './parkingSpace.dart';

class Parking {
  Vehicle fordon;
  ParkingSpace parkeringsplats;
  DateTime startTime;
  DateTime? endTime;
  Parking(
      {required this.startTime,
      required this.fordon,
      required this.parkeringsplats,
      this.endTime});
  @override
  String toString() {
    return 'Fordon: $fordon, Parkeringsplats: $parkeringsplats, startTime: $startTime, endTime: $endTime';
  }
}
