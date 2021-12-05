import 'package:flutter/material.dart';
import '../computasus_db.dart';
import 'package:sqflite/sqflite.dart';

class Pacientes extends StatefulWidget {
  const Pacientes({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<Pacientes> createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {
  List<Usuario> pacientes = [];

  Future<List<Usuario>> getPacientes(int id) async {
    List<Atende> at = await atende();
    at.removeWhere((element) => element.id_profissional != id);
    List<int> id_pacientes = at.map<int>((e) => e.id_paciente).toList();
    List<Usuario> pacientes = await usuario();
    pacientes.removeWhere((e) => !id_pacientes.contains(e.id));
    return pacientes;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPacientes(super.widget.id).then((value) {
      setState(() {
        pacientes = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                child: Text(
                  "Monitorar pacientes:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Column(
              children: List.generate(pacientes.length, (i) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                              child: Icon(
                            Icons.person,
                            size: 40,
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                "${pacientes[i].nome}, ${pacientes[i].idade} anos.",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(pacientes[i].email)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
