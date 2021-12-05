import 'package:flutter/material.dart';
import 'package:hack4health/pages/TelaCliente.dart';
import 'package:hack4health/pages/TelaMedico.dart';
import '../computasus_db.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  //final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 120,
                ),
                /*TextFormField(
                  cursorColor: Colors.green[800],
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                  hintText: 'Digite seu nome'
                  ),
                ),
                Container(
                  height: 30,
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  cursorColor: Colors.green[800],
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                    hintText: 'Digite sua senha'
                  ),
                ),
                Container(
                  height: 100,
                ),*/
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[800],
                    onSurface: Colors.green,
                    elevation: 5,
                    shadowColor: Colors.green[800],
                  ),
                  child: Text(
                    'Entrar como Cliente',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelaCliente()),
                    );
                  },
                ),
                Container(
                  height: 100,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[800],
                    onSurface: Colors.blue,
                    elevation: 5,
                    shadowColor: Colors.blue[800],
                  ),
                  child: Text(
                    'Entrar como Médico',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelaMedico()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
