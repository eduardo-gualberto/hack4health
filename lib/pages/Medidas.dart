import 'package:flutter/material.dart';
import 'package:heart_bpm/heart_bpm.dart';

class Medidas extends StatefulWidget {
  const Medidas({Key? key}) : super(key: key);

  @override
  State<Medidas> createState() => _MedidasState();
}

class _MedidasState extends State<Medidas> {
  int _selectedIndex = 0;
  List<SensorValue> data = [];
  int bpmValue = 0;
  bool enableBPM = false;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Medidas',
      style: optionStyle,
    ),
    Text(
      'Index 1: Home',
      style: optionStyle,
    ),
    Text(
      'Index 2: Chat',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem vindo, Paulo!'),
        backgroundColor: Colors.green[800],
        actions: <Widget>[
          TextButton(
            style: style,
            onPressed: () {},
            child: const Text('Score'),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            enableBPM
                ? HeartBPMDialog(
              context: context,
              onRawData: (value) {
                setState(() {
                  if (data.length == 50) data.removeAt(0);
                  data.add(value);
                });
              },
              onBPM: (value) => setState(() {
                bpmValue = value;
              }),
            )
                : SizedBox(),
            Text(
                '$bpmValue BPM',
                style: Theme.of(context).textTheme.bodyText2
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  enableBPM = !enableBPM;
                });
              },
              child: Icon(Icons.favorite),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      /*body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),*/
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