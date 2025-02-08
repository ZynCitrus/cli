class ParkingSpace {
  int id;
  String adress;
  int perHour;
  ParkingSpace({required this.adress, required this.id, required this.perHour});

  @override
  String toString() {
    return 'Adress: $adress, Kostnad per timme: $perHour per timme';
  }
}
