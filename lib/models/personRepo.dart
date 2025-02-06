import 'person.dart';

class PersonRepository {
  List<Person> personer = [];

  void add(Person person) {
    personer.add(person);
  }

  List<Person> getAll() {
    return personer;
  }

  void delete(int index) {
    if (index >= 0 && index < personer.length) {
      personer.removeAt(index);
    }
  }
}
