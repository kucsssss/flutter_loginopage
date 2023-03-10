import 'package:uuid/uuid.dart';

class Person {
  final String id;
  final String name;

  Person({
    required this.id,
    required this.name,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  factory Person.newPerson(String name) {
    return Person(
      id: Uuid().v4(),
      name: name,
    );
  }
}
