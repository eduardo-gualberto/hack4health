import 'package:flutter/material.dart';
import 'package:hack4health/pages/Pacientes.dart';
import 'package:hack4health/pages/Chat.dart';

class TelaMedico extends StatefulWidget {
  const TelaMedico({Key? key}) : super(key: key);

  @override
  State<TelaMedico> createState() => _TelaMedicoState();
}

class _TelaMedicoState extends State<TelaMedico> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Pacientes(),
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
        title: const Text('Bem vindo, Dr. Alberto!'),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pacientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
