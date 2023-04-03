import 'package:flutter/material.dart';
import 'api.dart';
import 'person.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required person}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<List<Person>> _futurePersons = Api.getPersons();

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      final persons = await _futurePersons;

      final currentUserIndex = persons.indexWhere(
        (person) => person.name == username,
      );
      final currentUser =
          currentUserIndex > -1 ? persons[currentUserIndex] : null;

      if (currentUser != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) => LayoutBuilder(
            builder: (_, constrains) => AlertDialog(
                title: Text('Szia, ${currentUser.name}'),
                scrollable: true,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('A te ID-d: ${currentUser.id}'),
                    SizedBox(height: 8),
                    Text('A felhasznalok:'),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var person in persons)
                          Text(
                            person.name,
                            style: TextStyle(fontSize: 20),
                          )
                      ],
                    ),
                  ],
                )),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Hiba'),
            content: Text('Nincs ilyen nevu felhasznalo'),
          ),
        );
      }
    } catch (e) {
      print('Hiba a felhasznalo keresese kozben: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Hiba'),
          content: Text('Nem sikerult megtalalni a felhasznalot'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('teszt'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Felhasznalo nev',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Jelszo',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Belepes'),
            ),
          ],
        ),
      ),
    );
  }
}
