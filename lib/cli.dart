import 'dart:io';
import 'models/person.dart';
import 'models/vehicle.dart';
import 'models/parkingSpace.dart';
import 'models/parking.dart';
import 'models/personRepo.dart';
import 'models/parkingRepo.dart';
import 'models/parkingSpaceRepo.dart';
import 'models/vehicleRepo.dart';

void menu() {
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
      case '1': // Personmeny
        bool personMenuActive = true;

        while (personMenuActive) {
          stdout.writeln("1. Lägg till");
          stdout.writeln("2. Ta bort");
          stdout.writeln('3. Uppdatera anvandare');
          stdout.writeln("4. Se personer");
          stdout.writeln("5. Tillbaka");

          final personVal = stdin.readLineSync();

          switch (personVal) {
            case '1': // Lägg till ny person
              stdout.writeln('Lägg till ny person');
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
            case '2': // Ta bort person
              final allPersons = personRepository.getAll();

              stdout.writeln('Vilken person vill du ta bort?');
              stdout.writeln("Registrerade personer:");
              if (allPersons.isEmpty) {
                stdout.writeln("Inga personer registrerade ännu.");
              } else {
                for (var i = 0; i < allPersons.length; i++) {
                  print('${i + 1}: ${allPersons[i]}');
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
            case '3': // Uppdatera person
              stdout.writeln('Vilken person vill du uppdatera?');
              final allPersons = personRepository.getAll();
              stdout.writeln("Registrerade personer:");
              if (allPersons.isEmpty) {
                stdout.writeln("Inga personer registrerade ännu.");
              } else {
                for (var i = 0; i < allPersons.length; i++) {
                  print('${i + 1}: ${allPersons[i]}');
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
            case '4': // Se personer
              personRepository.seeAllPersons();
              break;
            case '5': // Tillbaka
              personMenuActive = false;
              break;

            default:
              stdout.writeln("Ogiltigt val.");
          }
        }
        break;
      case '2': // Fordonsmeny
        bool carMenuActive = true;

        while (carMenuActive) {
          stdout.writeln("1. Lägg till");
          stdout.writeln("2. Ta bort");
          stdout.writeln('3. Uppdatera fordon');
          stdout.writeln("4. Se fordon");
          stdout.writeln("5. Tillbaka");

          final carVal = stdin.readLineSync();

          switch (carVal) {
            case '1': // Lägg till fordon
              stdout.writeln('Ange registreringsnummer');
              String? regNr = stdin.readLineSync();

              stdout.writeln('Fordonstyp (Bil, MC, etc.)');
              String? typ = stdin.readLineSync();

              final allPersons = personRepository.getAll();
              if (allPersons.isEmpty) {
                stdout
                    .writeln('Inga regisrerade personer, registrera dig först');
                break;
              }

              stdout.writeln('välj ägare från listan');
              for (var i = 0; i < allPersons.length; i++) {
                stdout.writeln(
                    '${i + 1}: ${allPersons[i].name} (personnummer: ${allPersons[i].personnummer})');
              }

              stdout.writeln('Ange nummer for person');
              String? ownerIndexInput = stdin.readLineSync();
              int? ownerIndex = int.tryParse(ownerIndexInput ?? '');

              if (regNr != null &&
                  typ != null &&
                  ownerIndex != null &&
                  ownerIndex > 0 &&
                  ownerIndex <= allPersons.length) {
                Person owner = allPersons[ownerIndex - 1];
                Vehicle newVehicle = Vehicle(
                  registreringsnummer: regNr,
                  typAvFordon: typ,
                  owner: owner,
                );

                vehicleRepository.addVehicle(newVehicle);
                stdout.writeln("Nytt fordon tillagt: $newVehicle");
              } else {
                stdout.writeln("Felaktig inmatning.");
                break;
              }
              break;
            case '2': // Ta bort fordon
              final allVehicles = vehicleRepository.getAll();
              stdout.writeln('Registrerade fordon:');
              for (var i = 0; i < allVehicles.length; i++) {
                print('${i + 1}: ${allVehicles[i]}');
              }
              stdout.writeln('Valj ett fordon att ta bort');
              final input = stdin.readLineSync();
              final index = int.tryParse(input!);

              if (index != null && index > 0 && index <= allVehicles.length) {
                vehicleRepository.removeVehicle(index - 1);
                stdout.writeln('Fordon borttaget');
              } else {
                stdout.writeln('ogiltigt val');
                break;
              }

              break;
            case '3': // Uppdatera fordon
              stdout.writeln('Vilket fordon vill du uppdatera?');

              final allVehicles = vehicleRepository.getAll();
              stdout.writeln("Registrerade fordon:");
              if (allVehicles.isEmpty) {
                stdout.writeln("Inga fordon registrerade ännu.");
                break;
              }

              for (var i = 0; i < allVehicles.length; i++) {
                stdout.writeln('${i + 1}: ${allVehicles[i]}');
              }

              stdout.writeln('Välj ett fordon att uppdatera:');
              final input = stdin.readLineSync();
              final index = int.tryParse(input ?? '');

              if (index != null && index > 0 && index <= allVehicles.length) {
                Vehicle existingVehicle = allVehicles[index - 1];

                String regNr = existingVehicle.registreringsnummer;
                String typeOfVehicle = existingVehicle.typAvFordon;

                stdout.writeln('Registreringsnummer: $regNr');

                stdout.writeln('Fordonstyp: $typeOfVehicle:');

                final allPersons = personRepository.getAll();
                stdout
                    .writeln('Nuvarande ägare: ${existingVehicle.owner.name}');
                stdout.writeln(
                    'Välj ny ägare från listan eller tryck Enter för att behålla befintlig ägare:');

                for (var i = 0; i < allPersons.length; i++) {
                  stdout.writeln(
                      '${i + 1}: ${allPersons[i].name} (Personnummer: ${allPersons[i].personnummer})');
                }

                stdout.writeln("Ange nummer för ny ägare:");
                String? newOwnerIndexInput = stdin.readLineSync();
                int? newOwnerIndex = int.tryParse(newOwnerIndexInput ?? '');

                Person newOwner = existingVehicle.owner;
                if (newOwnerIndex != null &&
                    newOwnerIndex > 0 &&
                    newOwnerIndex <= allPersons.length) {
                  newOwner = allPersons[newOwnerIndex - 1];
                }

                Vehicle updatedVehicle = Vehicle(
                  registreringsnummer: regNr,
                  typAvFordon: typeOfVehicle,
                  owner: newOwner,
                );

                vehicleRepository.update(index - 1, updatedVehicle);
                stdout.writeln('Fordon uppdaterat: $updatedVehicle');
              } else {
                stdout.writeln("Ogiltigt val.");
              }
              break;
            case '4': // Se alla fordon
              final allVehicles = vehicleRepository.getAll();
              if (allVehicles.isEmpty) {
                stdout.writeln("Inga fordon registrerade.");
              } else {
                for (var i = 0; i < allVehicles.length; i++) {
                  stdout.writeln('${i + 1}: ${allVehicles[i]}');
                }
              }
              break;
            case '5': // Avsluta
              carMenuActive = false;
              break;
          }
        }
      case '3': // Parkeringsplatsmeny
        bool parkingspaceMenuActive = true;

        while (parkingspaceMenuActive) {
          stdout.writeln("1. Lägg till");
          stdout.writeln("2. Ta bort");
          stdout.writeln('3. Uppdatera parkeringsplats');
          stdout.writeln("4. Se parkeringsplats");
          stdout.writeln("5. Tillbaka");

          final parkingspaceVal = stdin.readLineSync();

          switch (parkingspaceVal) {
            case '1': // Lägg till parkeringsplats
              stdout.writeln('Lägg till parkeringsplats:');
              stdout.writeln('Mata in ID:');
              String? idInput = stdin.readLineSync();
              stdout.writeln('Mata in Adress:');
              String? adress = stdin.readLineSync();
              stdout.writeln('Mata in kostnad per timme:');
              String? perHourInput = stdin.readLineSync();

              if (idInput != null && adress != null && perHourInput != null) {
                int? id = int.tryParse(idInput);
                int? perHour = int.tryParse(perHourInput);

                if (id != null && perHour != null) {
                  ParkingSpace newParkingSpace =
                      ParkingSpace(id: id, adress: adress, perHour: perHour);
                  parkingSpaceRepository.addParkingSpace(newParkingSpace);
                  stdout.writeln("Ny parkeringsplats skapad: $newParkingSpace");
                } else {
                  stdout.writeln(
                      "Ogiltigt ID eller kostnad per timme. Ange heltal.");
                }
              }
              break;
            case '2': // Ta bort parkeringsplats
              final allParkingspots = parkingSpaceRepository.getAll();
              stdout.writeln('Ta bort parkeringsplats!');
              stdout.writeln('Registrerade parkeringsplatser:');
              if (allParkingspots.isEmpty) {
                stdout.writeln('Finns inga registreringsplatser');
                break;
              } else {
                for (var i = 0; i < allParkingspots.length; i++) {
                  print('${i + 1} ${allParkingspots[i]}');
                }
              }
              stdout.writeln('Välj en parkeringsplats att ta bort');
              final input = stdin.readLineSync();
              final index = int.tryParse(input!);

              if (index != null &&
                  index > 0 &&
                  index <= parkingSpaceRepository.getAll().length) {
                parkingSpaceRepository.removeParkingSpace(index - 1);
                stdout.writeln('Du har tagit bort parkeringsplatsen');
              } else {
                stdout.writeln('Ogiltigt val');
              }
              break;
            case '3': // Uppdatera parkeringsplats
              stdout.writeln('Uppdatera parkeringsplats');
              final allParkingspots = parkingSpaceRepository.getAll();
              stdout.writeln('Registrerade parkeringsplatser');
              if (allParkingspots.isEmpty) {
                stdout.writeln('Inga registrerade parkeringsplatser.');
              } else {
                for (var i = 0; i < allParkingspots.length; i++) {
                  print('${i + 1}: ${allParkingspots[i]}');
                }
              }
              stdout.writeln('Välj parkeringsplats att uppdatera:');
              final input = stdin.readLineSync();
              final index = int.tryParse(input!);
              if (index != null &&
                  index > 0 &&
                  index <= parkingSpaceRepository.getAll().length) {
                ParkingSpace existingSpace =
                    parkingSpaceRepository.getAll()[index - 1];

                stdout.writeln('Ange nytt Id eller enter för att behålla');
                String? newId = stdin.readLineSync();
                stdout.writeln('Ange ny adress eller enter för att behålla');
                String? newAdress = stdin.readLineSync();
                stdout.writeln('Ange nytt timpris eller enter för att behålla');
                String? newPerHour = stdin.readLineSync();

                int updatedId = newId?.isNotEmpty == true
                    ? int.tryParse(newId!) ?? existingSpace.id
                    : existingSpace.id;

                String updatedAdress = newAdress?.isNotEmpty == true
                    ? newAdress!
                    : existingSpace.adress;

                int updatedPerHour = newPerHour?.isNotEmpty == true
                    ? int.tryParse(newPerHour!) ?? existingSpace.perHour
                    : existingSpace.perHour;

                ParkingSpace updatedSpace = ParkingSpace(
                    id: updatedId,
                    adress: updatedAdress,
                    perHour: updatedPerHour);

                parkingSpaceRepository.updateParkingSpace(
                    index - 1, updatedSpace);
                stdout.writeln('Parkeringsplats uppdaterad: $updatedSpace');
              } else {
                stdout.writeln('Ogiltigt index.');
              }
              break;
            case '4': // Se parkeringsplatser
              final allParkingspots = parkingSpaceRepository.getAll();
              stdout.writeln("Registrerade parkeringsplatser:");
              if (allParkingspots.isEmpty) {
                stdout.writeln("Inga parkeringsplatser registrerade ännu.");
              } else {
                for (var i = 0; i < allParkingspots.length; i++) {
                  print('${i + 1}: ${allParkingspots[i]}');
                }
              }

              break;
            case '5': // Avsluta
              parkingspaceMenuActive = false;
              break;
          }
        }
      case '4': // Parkeringsmeny
        bool parkingMenuActive = true;

        while (parkingMenuActive) {
          stdout.writeln("1. Starta parkering");
          stdout.writeln("2. Avsluta parkering");
          stdout.writeln('3. Uppdatera parkering');
          stdout.writeln("4. Se parkering");
          stdout.writeln("5. Tillbaka");

          final parkingVal = stdin.readLineSync();

          switch (parkingVal) {
            case '1': // Lägg till parkering
              stdout.writeln('Starta parkering');
              final allVehicles = vehicleRepository.getAll();
              if (allVehicles.isEmpty) {
                stdout.writeln(
                    'Finns inga fordon registrerade, lägg till ett fordon först.');
              } else {
                for (var i = 0; i < allVehicles.length; i++) {
                  stdout.writeln('${i + 1}: ${allVehicles[i]}');
                }
                stdout.writeln(
                    'Välj nummer för fordon du vill starta en parkering för:');
                String? vehicleIndexInput = stdin.readLineSync();
                int? vehicleIndex = int.tryParse(vehicleIndexInput ?? '');

                if (vehicleIndex == null ||
                    vehicleIndex < 1 ||
                    vehicleIndex > allVehicles.length) {
                  stdout.writeln('ogiltigt val');
                  break;
                }

                Vehicle selectedVehicle = allVehicles[vehicleIndex - 1];

                final allParkingSpaces = parkingSpaceRepository.getAll();
                if (allParkingSpaces.isEmpty) {
                  stdout.writeln(
                      "Inga registrerade parkeringsplatser. Kontakta supporten");
                  break;
                }

                stdout.writeln('välj en parkeringsplats:');
                for (var i = 0; i < allParkingSpaces.length; i++) {
                  stdout.writeln("${i + 1}: ${allParkingSpaces[i]}");
                }

                stdout.writeln("Ange numret för parkeringsplatsen:");
                String? parkingIndexInput = stdin.readLineSync();
                int? parkingIndex = int.tryParse(parkingIndexInput ?? '');

                if (parkingIndex == null ||
                    parkingIndex < 1 ||
                    parkingIndex > allParkingSpaces.length) {
                  stdout.writeln("Ogiltigt val av parkeringsplats.");
                  break;
                }

                ParkingSpace selectedParkingSpace =
                    allParkingSpaces[parkingIndex - 1];

                Parking newParking = Parking(
                  startTime: DateTime.now(),
                  fordon: selectedVehicle,
                  parkeringsplats: selectedParkingSpace,
                );

                parkingRepository.addParking(newParking);
                stdout.writeln("Ny parkering skapad: $newParking");
                stdout.writeln(
                    "Antal parkeringar i repository: ${parkingRepository.getAll().length}");

                break;
              }

              break;
            case '2': // Avsluta parkering
              stdout.writeln('Avsluta parkering:');
              stdout.writeln('Välj ditt fordon:');
              final allVehicles = vehicleRepository.getAll();
              if (allVehicles.isEmpty) {
                stdout.writeln('Finns inga fordon, registrera ett först');
              }
              for (var i = 0; i < allVehicles.length; i++) {
                stdout.writeln('${i + 1}: ${allVehicles[i]}');
              }

              stdout.writeln('Ange numret for ditt fordon');
              String? vehicleIndexInput = stdin.readLineSync();
              int? vehicleIndex = int.tryParse(vehicleIndexInput ?? '');
              if (vehicleIndex == null ||
                  vehicleIndex < 1 ||
                  vehicleIndex > allVehicles.length) {
                stdout.writeln("Ogiltigt val.");
                break;
              }
              Vehicle selectedVehicle = allVehicles[vehicleIndex - 1];
              final activeParkings = parkingRepository
                  .getAll()
                  .where((p) =>
                      p.fordon.registreringsnummer ==
                          selectedVehicle.registreringsnummer &&
                      p.endTime == null)
                  .toList();
              if (activeParkings.isEmpty) {
                stdout.writeln(
                    "Det finns inga aktiva parkeringar för detta fordon.");
                break;
              }
              stdout.writeln('välj en parkering att avsluta');
              for (var i = 0; i < activeParkings.length; i++) {
                stdout.writeln('${i + 1}: ${activeParkings[i]}');
              }
              stdout.writeln("Ange numret för parkeringen att avsluta:");
              String? parkingIndexInput = stdin.readLineSync();
              int? parkingIndex = int.tryParse(parkingIndexInput ?? '');
              if (parkingIndex == null ||
                  parkingIndex < 1 ||
                  parkingIndex > activeParkings.length) {
                stdout.writeln("Ogiltigt val.");
                break;
              }

              activeParkings[parkingIndex - 1].endTime = DateTime.now();
              stdout.writeln(
                  "Parkeringen har avslutats: ${activeParkings[parkingIndex - 1]}");
              break;
            case '3': // Uppdatera parkering
              stdout.writeln('Inte implementerat ännu');
              break;
            case '4': // Se parkeringar
              stdout.writeln('Parkeringar:');
              final allParkings = parkingRepository.getAll();
              stdout.writeln("Registrerade parkeringar:");
              if (allParkings.isEmpty) {
                stdout.writeln("Inga parkeringar registrerade ännu.");
              } else {
                for (var i = 0; i < allParkings.length; i++) {
                  print('${i + 1}: ${allParkings[i]}');
                }
              }
              break;
            case '5': // avsluta
              parkingMenuActive = false;
              break;
          }
        }
      case '5': // Avsluta
        mainMenuActive = false;
        stdout.writeln("Avslutar programmet.");
        break;

      default:
        stdout.writeln("Ogiltigt val.");
    }
  }
}
