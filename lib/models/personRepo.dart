import 'person.dart';
import 'dart:io';

class PersonRepository {
  List<Person> personer = [
    Person(
      name: 'Erik',
      personnummer: 198902322332,
    ),
    Person(
      name: 'Anna',
      personnummer: 199001011234,
    ),
    Person(
      name: 'Lars',
      personnummer: 197505055555,
    ),
    Person(
      name: 'Maria',
      personnummer: 199203234444,
    ),
    Person(
      name: 'Johan',
      personnummer: 198707071212,
    ),
  ];

  void add(Person person) {
    personer.add(person);
  }

  List<Person> getAll() {
    return personer;
  }

  void seeAllPersons() {
    final allPersons = getAll();
    stdout.writeln("Registrerade personer:");
    if (allPersons.isEmpty) {
      stdout.writeln("Inga personer registrerade ännu.");
    } else {
      for (var i = 0; i < allPersons.length; i++) {
        print('${i + 1}: ${allPersons[i]}');
      }
    }
  }

  void update(int index, Person newPerson) {
    if (index >= 0 && index < personer.length) {
      personer[index] = newPerson;
    }
  }

  void delete(int index) {
    if (index >= 0 && index < personer.length) {
      personer.removeAt(index);
    }
  }
}
