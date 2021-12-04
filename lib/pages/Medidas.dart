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
  String stress_option = "Baixo";
  String depression_option = "Baixo";
  String ativ_fis = "Nenhuma";

  int getMeanBPM() {
    double acc_bpm = 0;
    int n = data.length;
    for (var bpm in data) {
      acc_bpm += bpm.value / n;
    }
    return acc_bpm.toInt();
  }

  void onAferirFreqCardiaca(BuildContext ctx) {
    setState(() {
      enableBPM = !enableBPM;
    });
    new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (this.freq_c_progress >= 1) {
          enableBPM = !enableBPM;
          btn_disable = true;
          Navigator.pop(ctx);
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
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          // enableBPM
          //     ? Center(
          //         child: HeartBPMDialog(
          //           sampleDelay: 1000 ~/ 30,
          //           context: context,
          //           onRawData: (value) {
          //             setState(() {
          //               if (data.length == 100) data.removeAt(0);
          //               data.add(value);
          //             });
          //           },
          //           onBPM: (value) => setState(() {
          //             bpmValue = getMeanBPM();
          //           }),
          //         ),
          //       )
          //     : SizedBox(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: FloatingActionButton(
                        backgroundColor:
                            btn_disable ? Colors.green[800] : Colors.red,
                        onPressed: btn_disable
                            ? null
                            : () async {
                                onAferirFreqCardiaca(context);
                                BuildContext ctx = context;
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      ctx = context;
                                      return Center(
                                        child: HeartBPMDialog(
                                          sampleDelay: 1000 ~/ 30,
                                          context: ctx,
                                          onRawData: (value) {
                                            setState(() {
                                              if (data.length == 100)
                                                data.removeAt(0);
                                              data.add(value);
                                            });
                                          },
                                          onBPM: (value) => setState(() {
                                            bpmValue = getMeanBPM();
                                          }),
                                        ),
                                      );
                                    });
                              },
                        child: Icon(
                          Icons.favorite,
                          size: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        btn_disable ? "Pronto" : "Iniciar",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
                Text('$bpmValue BPM',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          Container(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Outras informações:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Align(
                          child: Text("Peso"),
                          alignment: Alignment.centerLeft,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Ex.: 82,5 (kg)",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Nível de Estresse"),
                        DropdownButton(
                          value: stress_option,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Colors.green[800],
                          ),
                          onChanged: (String? newValue) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              stress_option = newValue!;
                            });
                          },
                          onTap: () {
                            FocusManager.instance.primaryFocus!.unfocus();
                          },
                          items: <String>[
                            'Baixo',
                            'Moderado',
                            'Alto',
                            'Muito Alto'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Nível de Desânimo"),
                      DropdownButton(
                        value: depression_option,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: Colors.green[800],
                        ),
                        onChanged: (String? newValue) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            depression_option = newValue!;
                          });
                        },
                        onTap: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        items: <String>[
                          'Baixo',
                          'Moderado',
                          'Alto',
                          'Muito Alto'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Atividade Física"),
                      DropdownButton(
                        value: ativ_fis,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        underline: Container(
                          height: 2,
                          color: Colors.green[800],
                        ),
                        onChanged: (String? newValue) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            ativ_fis = newValue!;
                          });
                        },
                        onTap: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        items: <String>[
                          'Nenhuma',
                          'Leve',
                          'Moderada',
                          'Intensa'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                  child: SizedBox(
                      width: 120,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Enviar",
                            style: TextStyle(fontSize: 17),
                          )))),
            ),
          )
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
