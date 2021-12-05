import 'package:flutter/material.dart';
import 'package:hack4health/computasus_db.dart';
import 'package:hack4health/pages/Medidas.dart';
import 'package:hack4health/pages/Home.dart';
import 'package:hack4health/pages/Chat.dart';

class Tela extends StatefulWidget {
  const Tela({Key? key, required this.user}) : super(key: key);
  final Usuario user;
  @override
  State<Tela> createState() => _TelaState();
}

class _TelaState extends State<Tela> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Medidas(),
    Home(),
    Chat(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem vindo, Paulo!'),
        backgroundColor: Colors.green[800],
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            tooltip: 'Score',
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.addchart),
            label: 'Medidas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
