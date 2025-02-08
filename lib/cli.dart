import 'dart:io';
import 'models/person.dart';
import 'models/vehicle.dart';
import 'models/parkingSpace.dart';
import 'models/parking.dart';
import 'models/personRepo.dart';
import 'models/parkingRepo.dart';
import 'models/parkingSpaceRepo.dart';
import 'models/vehicleRepo.dart';

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
                  personRepository.add(newPerson);
                  stdout.writeln("Ny person skapad: $newPerson");
                } else {
                  stdout.writeln("Ogiltigt personnummer.");
                }
              } else {
                stdout.writeln("Felaktig inmatning.");
              }
              break;
            case '2':
              final allPersons = personRepository.getAll();

              stdout.writeln('Vilken person vill du ta bort?');
              stdout.writeln("Registrerade personer:");
              if (allPersons.isEmpty) {
                stdout.writeln("Inga personer registrerade ännu.");
              } else {
                for (var i = 0; i < allPersons.length; i++) {
                  print('${i + 1}: ${allPersons[i]}}');
                }
              }
              stdout.writeln('Välj person att ta bort');
              final input = stdin.readLineSync();
              final index = int.tryParse(input!);

              if (index != null &&
                  index > 0 &&
                  index <= personRepository.getAll().length) {
                personRepository.delete(index - 1);
                stdout.writeln('Du har tagit bort personen');
              } else {
                stdout.writeln('Ogiltigt val.');
              }
              break;
            case '3':
              stdout.writeln('Vilken person vill du uppdatera?');
              final allPersons = personRepository.getAll();
              stdout.writeln("Registrerade personer:");
              if (allPersons.isEmpty) {
                stdout.writeln("Inga personer registrerade ännu.");
              } else {
                for (var person in allPersons) {
                  stdout.writeln(person);
                }
              }
              stdout.writeln('Välj en person att uppdatera');
              final input = stdin.readLineSync();
              final index = int.tryParse(input!);
              if (index != null &&
                  index > 0 &&
                  index <= personRepository.getAll().length) {
                stdout.writeln(
                    'Ange nytt namn eller enter för att behålla befintligt:');
                String? newName = stdin.readLineSync();
                stdout.writeln(
                    'Ange nytt personnummer eller enter för att behålla befintligt:');
                String? newPersonnummerInput = stdin.readLineSync();

                Person existingPerson = allPersons[index - 1];

                String? updatedName =
                    newName?.isNotEmpty == true ? newName : existingPerson.name;
                int updatedPersonnummer;

                if (newPersonnummerInput?.isNotEmpty == true) {
                  int? parsedPersonnummer = int.tryParse(newPersonnummerInput!);
                  if (parsedPersonnummer != null) {
                    updatedPersonnummer = parsedPersonnummer;
                  } else {
                    stdout.writeln(
                        "Ogiltigt personnummer. Behåller befintligt personnummer.");
                    updatedPersonnummer = existingPerson.personnummer;
                  }
                } else {
                  updatedPersonnummer = existingPerson.personnummer;
                }
                if (updatedName != null) {
                  Person updatedPerson = Person(
                      name: updatedName, personnummer: updatedPersonnummer);
                  personRepository.update(index - 1, updatedPerson);
                  stdout.writeln('Person uppdaterad: $updatedPerson');
                } else {
                  stdout.writeln('Ogiltigt val.');
                }
              }
              break;

            case '4':
              final allPersons = personRepository.getAll();
              stdout.writeln("Registrerade personer:");
              if (allPersons.isEmpty) {
                stdout.writeln("Inga personer registrerade ännu.");
              } else {
                for (var person in allPersons) {
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
      case '2':
        bool carMenuActive = true;

        while (carMenuActive) {
          stdout.writeln("1. Lägg till");
          stdout.writeln("2. Ta bort");
          stdout.writeln('3. Uppdatera fordon');
          stdout.writeln("4. Se fordon");
          stdout.writeln("5. Tillbaka");

          final carVal = stdin.readLineSync();

          switch (carVal) {
            case '5':
              carMenuActive = false;
              break;
          }
        }
      case '3':
        bool parkingspotMenuActive = true;

        while (parkingspotMenuActive) {
          stdout.writeln("1. Lägg till");
          stdout.writeln("2. Ta bort");
          stdout.writeln('3. Uppdatera parkeringsplats');
          stdout.writeln("4. Se parkeringsplats");
          stdout.writeln("5. Tillbaka");

          final parkingspotVal = stdin.readLineSync();

          switch (parkingspotVal) {
            case '5':
              parkingspotMenuActive = false;
              break;
          }
        }
      case '4':
        bool parkingMenuActive = true;

        while (parkingMenuActive) {
          stdout.writeln("1. Lägg till");
          stdout.writeln("2. Ta bort");
          stdout.writeln('3. Uppdatera parkering');
          stdout.writeln("4. Se parkering");
          stdout.writeln("5. Tillbaka");

          final parkingVal = stdin.readLineSync();

          switch (parkingVal) {
            case '5':
              parkingMenuActive = false;
              break;
          }
        }
      case '5':
        mainMenuActive = false;
        stdout.writeln("Avslutar programmet.");
        break;

      default:
        stdout.writeln("Ogiltigt val.");
    }
  }
}
