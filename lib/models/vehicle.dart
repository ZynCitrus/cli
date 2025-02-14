import './person.dart';

class Vehicle {
  String registreringsnummer;
  String typAvFordon;
  Person owner;
  Vehicle(
      {required this.owner,
      required this.registreringsnummer,
      required this.typAvFordon});

  @override
  String toString() {
    return 'Ägare: $owner, Registreringsnummer: $registreringsnummer, Fordonstyp: $typAvFordon';
  }
}
