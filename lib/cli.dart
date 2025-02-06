import 'dart:io';
import 'models/person.dart';
import 'models/vehicle.dart';
import 'models/parkingSpace.dart';
import 'models/parking.dart';
import 'models/personRepo.dart';
import 'models/parkingRepo.dart';
import 'models/parkingSpaceRepo.dart';
import 'models/vehicleRepo.dart';

class PersonRepository {
  List<Person> personer = [];

  void addPerson(Person person) {
    personer.add(person);
  }

  void removePerson(int index) {
    personer.removeAt(index);
  }

  List<Person> getAll() {
    return personer;
  }
}

List<Person> personer = [];

void main() {
  final personRepository = PersonRepository();
  final vehicleRepository = VehicleRepository();
  final parkingSpaceRepository = ParkingSpaceRepository();
  final parkingRepository = ParkingRepository();
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
          stdout.writeln('3. Uppdatera anvandare');
          stdout.writeln("4. Se personer");
          stdout.writeln("5. Tillbaka");

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
              print('Under uppbyggnad');
              break;

            case '4':
              stdout.writeln("Registrerade personer:");
              if (personer.isEmpty) {
                stdout.writeln("Inga personer registrerade ännu.");
              } else {
                for (var person in personer) {
                  stdout.writeln(person);
                }
              }
              break;

            case '5':
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
