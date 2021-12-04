import 'package:flutter/material.dart';
import 'package:hack4health/pages/Medidas.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
    final nomeTxt = TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)),
        hintText: 'Digite seu nome'
      ),
    );

    final senhaTxt = TextField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        fillColor: Colors.green[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)),
          //borderColor: Colors.white,
        hintText: 'Digite seu senha'
      ),
    );

    final botaoLogin = TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.green[800],
      ),
      child: Text(
        'Entrar',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Medidas()),
        );
      },
    );

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
                nomeTxt,
                Container(
                  height: 30,
                ),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    fillColor: Colors.green[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                      //borderColor: Colors.white,
                    hintText: 'Digite seu senha'
                  ),
                ),
                Container(
                  height: 50,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green[800],
                  ),
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Medidas()),
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
