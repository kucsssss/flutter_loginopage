import 'package:flutter/material.dart';
import 'person.dart';
import 'api.dart';

class MainScreen extends StatefulWidget {
  final Person? person;
  final Function? onUpdate;

  MainScreen({required this.person, this.onUpdate});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Api _api = Api();
  List<Person> _persons = [];

  @override
  void initState() {
    super.initState();
    _loadPersons();
  }

  Future<void> _loadPersons() async {
    final persons = await Api.getPersons();
    setState(() {
      _persons = persons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person API Demo'),
      ),
      body: ListView.builder(
        itemCount: _persons.length,
        itemBuilder: (context, index) {
          final person = _persons[index];
          return ListTile(
            title: Text(person.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await Api.deletePerson(person.id);
                await _loadPersons();
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(
                    person: person,
                    onUpdate: () async {
                      await _loadPersons();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(
                onUpdate: () async {
                  await _loadPersons();
                }, person: null,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
