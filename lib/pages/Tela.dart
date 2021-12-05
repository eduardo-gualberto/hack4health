import 'package:flutter/material.dart';
import 'package:hack4health/computasus_db.dart';
import 'package:hack4health/pages/Medidas.dart';
import 'package:hack4health/pages/Home.dart';
import 'package:hack4health/pages/Chat.dart';
import 'package:hack4health/pages/Pacientes.dart';

class Tela extends StatefulWidget {
  const Tela({Key? key, required this.user}) : super(key: key);
  final Usuario user;
  @override
  State<Tela> createState() => _TelaState();
}

class _TelaState extends State<Tela> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions;
    if (widget.user.tipoUsuario == 0)
    {
      _widgetOptions = <Widget>[
          Medidas(),
          Home(),
          Chat(),
      ];
    }
    else 
    { 
      _widgetOptions = <Widget>[
        Pacientes(id: widget.user.id),
        Chat(),
      ];
    }

    return Scaffold(
      appBar: 
      widget.user.tipoUsuario == 0 ? AppBar(
        title: Text('Bem vindo, ' + widget.user.nome),
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
      ) : AppBar(
        title: Text('Bem vindo, ' + widget.user.nome),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: 
      widget.user.tipoUsuario == 0 ? BottomNavigationBar(
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
      ) : BottomNavigationBar(
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
        )
    );
  }
}
