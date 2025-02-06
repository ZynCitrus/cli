class Person {
  String name;
  int personnummer;
  Person({required this.name, required this.personnummer});

  @override
  String toString() {
    return 'Namn: $name, Personnummer: $personnummer';
  }
}
