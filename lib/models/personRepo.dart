import 'person.dart';

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
