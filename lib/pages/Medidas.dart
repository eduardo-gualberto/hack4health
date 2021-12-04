import 'package:flutter/material.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'dart:async';

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

  double freq_c_progress = 0;
  bool btn_disable = false;

  int getMeanBPM() {
    double acc_bpm = 0;
    int n = data.length;
    for (var bpm in data) {
      acc_bpm += bpm.value / n;
    }
    return acc_bpm.toInt();
  }

  void onAferirFreqCardiaca() {
    setState(() {
      enableBPM = !enableBPM;
    });
    new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (this.freq_c_progress >= 1) {
          enableBPM = !enableBPM;
          btn_disable = true;
          timer.cancel();
        }
        this.freq_c_progress += 1 / 10;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medidas'),
        backgroundColor: Colors.green[800],
        actions: <Widget>[
          TextButton(
            style: style,
            onPressed: () {},
            child: const Text('Score'),
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Tirar medidas cardíacas:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          enableBPM
              ? Center(
                  child: HeartBPMDialog(
                    sampleDelay: 1000 ~/ 30,
                    context: context,
                    onRawData: (value) {
                      setState(() {
                        if (data.length == 100) data.removeAt(0);
                        data.add(value);
                      });
                    },
                    onBPM: (value) => setState(() {
                      bpmValue = getMeanBPM();
                    }),
                  ),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: FloatingActionButton(
                        backgroundColor: btn_disable ? Colors.green[800] : Colors.red,
                        onPressed: btn_disable ? null : onAferirFreqCardiaca,
                        child: Icon(
                          Icons.favorite,
                          size: 40,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        btn_disable ? "Pronto" : "Iniciar",
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  ],
                ),
                Text('$bpmValue BPM',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          enableBPM
              ? Center(
                  child: LinearProgressIndicator(
                    color: Colors.green[800],
                  value: freq_c_progress,
                ))
              : Container(),
        ],
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
