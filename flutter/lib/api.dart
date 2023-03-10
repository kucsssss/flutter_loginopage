import 'dart:convert';
import 'package:http/http.dart' as http;
import 'person.dart';

class Api {
  static const endpoint = 'http://localhost:8080/api/v1/person';

  static Future<List<Person>> getPersons() async {
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final Iterable data = json.decode(response.body);
      return List<Person>.from(data.map((person) => Person.fromJson(person)));
    } else {
      throw Exception('Nem sikerult felhasznalot hozzaadni!');
    }
  }

  static Future<Person> addPerson(Person person) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(person.toJson()),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Person.fromJson(data);
    } else {
      throw Exception('Nem sikerult felhasznalot hozzaadni!');
    }
  }

  static Future<void> deletePerson(String id) async {
    final url = Uri.parse('$endpoint/$id');
    final response = await http.delete(url);
    if (response.statusCode != 204) {
      throw Exception('Nem sikerult felhasznalot torolni!');
    }
  }

  static Future<void> updatePerson(Person person) async {
    final url = Uri.parse('$endpoint/${person.id}');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(person.toJson()),
    );
    if (response.statusCode != 204) {
      throw Exception('Nem sikerult felhasznalot update-lni!');
    }
  }
}
