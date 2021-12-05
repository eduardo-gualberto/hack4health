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

  @override
  Widget build(BuildContext context) {
    Future<List<Usuario>> getPacientes() async {
      List<Atende> at = await atende();
      at.removeWhere((element) => element.id_profissional != widget.id);
      List<int> id_pacientes = at.map<int>((e) => e.id_paciente).toList();
      List<Usuario> pacientes = await usuario();
      pacientes.removeWhere((e) => !id_pacientes.contains(e.id));
      return pacientes;
    }

    getPacientes().then((value){
      setState(() {
        pacientes = value;
      });
    });

    return Scaffold(
      body: Center(
        child: Column(
          children:
              List.generate(pacientes.length, (i) => Text(pacientes[i].nome)),
        ),
      ),
    );
  }
}
