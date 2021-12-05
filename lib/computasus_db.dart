import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  int PAULO_KEY = 1234;
  int ALBERTO_KEY = 5678;

  final database = openDatabase(
    join(await getDatabasesPath(), 'computasus.db'),
    onCreate: (db, version) {
      return db.execute('CREATE TABLE Usuario(id INTEGER PRIMARY KEY, nome TEXT NOT NULL, email TEXT NOT NULL, senha TEXT NOT NULL, idade INTEGER NOT NULL, documento TEXT NOT NULL,' +
          'data_nascimento DATE NOT NULL, altura INTEGER, crm INTEGER, tipo_usuario BIT NOT NULL);\n ' +
          'CREATE TABLE Medicao(horario DATETIME, id_paciente INTEGER, peso FLOAT, stress INTEGER, desanimo INTEGER, atv_fisca INTEGER)' +
          '\nCONSTRAINT pk_medicao primary key(horario,id_paciente)\n' +
          'CONSTRAINT fk_paciente FOREIGN KEY(id_paciente) REFERENCES Usuario(id);\n' +
          'CREATE TABLE Atende(id_profissional, id_paciente)\n CONSTRAINT pk_atende PRIMARY KEY(id_profissional,id_paciente)\n' +
          'CONSTRAINT fk_profissional FOREIGN KEY(id_profissional) REFERENCES Usuario(id)\n' +
          'CONSTRAINT fk_paciente FOREIGN KEY(id_paciente) REFERENCES Usuario(id);');
    },
    version: 1,
  );

  Future<void> insertUsuario(Usuario usuario) async {
    final db = await database;

    await db.insert(
      'usuario',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMedicao(Medicao medicao) async {
    final db = await database;

    await db.insert(
      'medicao',
      medicao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAtende(Atende atende) async {
    final db = await database;

    await db.insert(
      'atende',
      atende.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Usuario>> usuario() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('usuario');

    return List.generate(maps.length, (i) {
      return Usuario(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        email: maps[i]['email'],
        senha: maps[i]['senha'],
        idade: maps[i]['idade'],
        documento: maps[i]['documento'],
        dataNascimento: maps[i]['dataNascimento'],
        altura: maps[i]['altura'],
        crm: maps[i]['crm'],
        tipoUsuario: maps[i]['tipoUsuario'],
      );
    });
  }

  Future<List<Medicao>> medicao() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('medicao');

    return List.generate(maps.length, (i) {
      return Medicao(
        horario: maps[i]['horario'],
        id_paciente: maps[i]['id_paciente'],
        peso: maps[i]['peso'],
        stress: maps[i]['stress'],
        desanimo: maps[i]['desanimo'],
        atv_fisica: maps[i]['atv_fisica'],
      );
    });
  }

  Future<List<Atende>> atende() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('atende');

    return List.generate(maps.length, (i) {
      return Atende(
        id_profissional: maps[i]['id_profissional'],
        id_paciente: maps[i]['id_paciente'],
      );
    });
  }

  Future<void> updateUsuario(Usuario usuario) async {
    final db = await database;
    await db.update(
      'usuario',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<void> updateMedicao(Medicao medicao) async {
    final db = await database;
    await db.update(
      'medicao',
      medicao.toMap(),
      where: '(horario,id_paciente) = ?',
      whereArgs: [medicao.horario, medicao.id_paciente],
    );
  }

  Future<void> deleteUsuario(int id) async {
    final db = await database;

    await db.delete(
      'usuario',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteMedicao(DateTime horario, int id_paciente) async {
    final db = await database;

    await db.delete(
      'medicao',
      where: '(horario,id_paciente) = ?',
      whereArgs: [horario, id_paciente],
    );
  }

  Future<void> deleteAtende(int id_profissional, int id_paciente) async {
    final db = await database;

    await db.delete(
      'atende',
      where: '(id_profissional,id_paciente) = ?',
      whereArgs: [id_profissional, id_paciente],
    );
  }
}

class Usuario {
  final int id;
  final String nome;
  final String email;
  final String senha;
  final int idade;
  final String documento;
  final DateTime dataNascimento;
  int altura;
  String crm;
  final int tipoUsuario;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.idade,
    required this.documento,
    required this.dataNascimento,
    required this.tipoUsuario,
    this.altura = 0,
    this.crm = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'idade': idade,
      'documento': documento,
      'data_nascimento': dataNascimento,
      'tipo_usuario': tipoUsuario,
    };
  }

  @override
  String toString() {
    return 'Usuario{id: $id, npme: $nome, age: $idade, email: $email, senha: $senha, documento: $documento, ' +
        'data_nascimento: $dataNascimento, altura: $altura, crm: $crm, tipo_usuario: $tipoUsuario}';
  }
}

class Medicao {
  final DateTime horario;
  final int id_paciente;
  final double peso;
  final int stress;
  final int desanimo;
  final int atv_fisica;

  Medicao({
    required this.horario,
    required this.id_paciente,
    required this.peso,
    required this.stress,
    required this.desanimo,
    required this.atv_fisica,
  });

  Map<String, dynamic> toMap() {
    return {
      'horario': horario,
      'id_paciente': id_paciente,
      'peso': peso,
      'stress': stress,
      'desanimo': desanimo,
      'atv_fisica': atv_fisica,
    };
  }

  @override
  String toString() {
    return 'Medicao{horario: $horario, id_paciente: $id_paciente, peso: $peso, stress: $stress, desanimo: $desanimo, ' +
        'atv_fisica: $atv_fisica}';
  }
}

class Atende {
  final int id_profissional;
  final int id_paciente;

  Atende({
    required this.id_profissional,
    required this.id_paciente,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_profissional': id_profissional,
      'id_paciente': id_paciente,
    };
  }

  @override
  String toString() {
    return 'Atende{id_profissional: $id_profissional, id_paciente: $id_paciente}';
  }
}
