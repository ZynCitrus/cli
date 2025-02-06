import 'dart:io';

class Person {
  String name;
  int personnummer;
  Person({required this.name, required this.personnummer});

  @override
  String toString() {
    return 'Namn: $name, Personnummer: $personnummer';
  }
}

class Vehicle {
  int registreringsnummer;
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

class ParkingSpace {
  int id;
  String adress;
  int perHour;
  ParkingSpace({required this.adress, required this.id, required this.perHour});
}

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
}

List<Person> personer = [];

void main() {
  List<Person> personer = [];

  bool mainMenuActive = true;

  while (mainMenuActive) {
    stdout.writeln(
        "Välkommen till den mest smidiga parkeringsappen du varit med om!");
    stdout.writeln("Vad vill du hantera?");
    stdout.writeln("1. Personer");
    stdout.writeln("2. Fordon");
    stdout.writeln("3. Parkeringsplatser");
    stdout.writeln("4. Parkeringar");
    stdout.writeln("5. Avsluta");
    final input = stdin.readLineSync();

    switch (input) {
      case '1':
        bool personMenuActive = true;

        while (personMenuActive) {
          stdout.writeln("1. Lägg till");
          stdout.writeln("2. Ta bort");
          stdout.writeln("3. Se info");
          stdout.writeln("4. Tillbaka");

          final personVal = stdin.readLineSync();

          switch (personVal) {
            case '1':
              stdout.writeln('Ange namn:');
              String? name = stdin.readLineSync();

              stdout.writeln('Ange personnummer:');
              String? personnummerInput = stdin.readLineSync();

              if (name != null && personnummerInput != null) {
                int? personnummer = int.tryParse(personnummerInput);
                if (personnummer != null) {
                  Person newPerson =
                      Person(name: name, personnummer: personnummer);
                  personer.add(newPerson);
                  stdout.writeln("Ny person skapad: $newPerson");
                } else {
                  stdout.writeln("Ogiltigt personnummer.");
                }
              } else {
                stdout.writeln("Felaktig inmatning.");
              }
              break;
            case '2':
              stdout.writeln('Vilken person vill du ta bort?');
              stdout.writeln("Registrerade personer:");
              if (personer.isEmpty) {
                stdout.writeln("Inga personer registrerade ännu.");
              } else {
                for (var i = 0; i < personer.length; i++) {
                  print('${i + 1}: ${personer[i]}');
                }
              }
              stdout.writeln('Välj person att ta bort');
              final input = stdin.readLineSync();
              final index = int.tryParse(input!);

              personer.removeAt(index! - 1);
              stdout.writeln('Du har tagit bort personen');
              break;
            case '3':
              stdout.writeln("Registrerade personer:");
              if (personer.isEmpty) {
                stdout.writeln("Inga personer registrerade ännu.");
              } else {
                for (var person in personer) {
                  stdout.writeln(person);
                }
              }
              break;

            case '4':
              personMenuActive = false;
              break;

            default:
              stdout.writeln("Ogiltigt val.");
          }
        }
        break;

      case '5':
        mainMenuActive = false;
        stdout.writeln("Avslutar programmet.");
        break;

      default:
        stdout.writeln("Ogiltigt val.");
    }
  }
}
