import 'package:flutter/material.dart';
import 'package:hack4health/computasus_db.dart' as a;
import 'package:hack4health/main.dart';
import 'package:hack4health/pages/Tela.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String user = "";
  String password = "";

  bool auth(String user, String password) {
    return true;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    a.main();
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Coloque suas credenciais"
                ),
                TextField(
                  cursorColor: Colors.green[800],
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      hintText: 'Digite seu nome'),
                  onChanged: (value) {
                    user = value;
                  },
                ),
                Container(
                  height: 30,
                ),
                TextField(
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
                    hintText: 'Digite sua senha',
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                Container(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[800],
                    onSurface: Colors.green,
                    elevation: 5,
                    shadowColor: Colors.green[800],
                  ),
                  child: Text(
                    'Entrar',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    List<a.Usuario> users = await a.usuario();
                    for (var u in users) {
                      if (u.nome == user && u.senha == password) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Tela(user: u,)),
                        );
                      }
                    }
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
