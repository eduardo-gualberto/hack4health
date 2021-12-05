import 'package:flutter/material.dart';

class Pacientes extends StatefulWidget {
  const Pacientes({Key? key}) : super(key: key);

  @override
  State<Pacientes> createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text('vc esta na aba de pacientes!'),
      ),
    );
  }
}