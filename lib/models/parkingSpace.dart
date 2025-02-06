class ParkingSpace {
  int id;
  String adress;
  int perHour;
  ParkingSpace({required this.adress, required this.id, required this.perHour});

  @override
  String toString() {
    return 'id: $id, Adress: $adress, kostnad per timme: $perHour';
  }
}
