import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'computasus.db'),
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE Usuario(id INTEGER PRIMARY KEY, nome TEXT NOT NULL, email TEXT NOT NULL, senha TEXT NOT NULL, idade INTEGER NOT NULL, documento TEXT NOT NULL,' +
              'dataNascimento TEXT NOT NULL, altura INTEGER, crm INTEGER, tipoUsuario BIT NOT NULL);');
      await db.execute(
          'CREATE TABLE Medicao(horario TEXT, id_paciente INTEGER, freq INTEGER,peso FLOAT, stress INTEGER, desanimo INTEGER, atv_fisica INTEGER,' +
              'CONSTRAINT pk_medicao primary key(horario,id_paciente),' +
              'CONSTRAINT fk_paciente FOREIGN KEY(id_paciente) REFERENCES Usuario(id));');
      await db.execute(
          'CREATE TABLE Atende(id_profissional INTEGER, id_paciente INTEGER,' +
              'CONSTRAINT pk_atende PRIMARY KEY(id_profissional,id_paciente),' +
              'CONSTRAINT fk_profissional FOREIGN KEY(id_profissional) REFERENCES Usuario(id),' +
              'CONSTRAINT fk_paciente FOREIGN KEY(id_paciente) REFERENCES Usuario(id));');
    },
    version: 1,
  );
  return database;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  int PAULO_KEY = 1234;
  int ALBERTO_KEY = 5678;

  var paulo = Usuario(
    id: PAULO_KEY,
    nome: 'Paulo',
    email: 'paulo@gmail.com',
    senha: '123',
    idade: 38,
    documento: 'doc',
    dataNascimento: '1983-04-12',
    altura: 170,
    crm: '',
    tipoUsuario: 0,
  );
  var alberto = Usuario(
    id: ALBERTO_KEY,
    nome: 'alberto',
    email: 'alberto@gmail.com',
    senha: '1234',
    idade: 50,
    documento: '33',
    dataNascimento: '1971-03-21',
    altura: 0,
    crm: '111',
    tipoUsuario: 1,
  );

  var atendimento = Atende(
    id_paciente: PAULO_KEY,
    id_profissional: ALBERTO_KEY,
  );

  var medida1 = Medicao(
      horario: "2021-11-23 09:13:02",
      id_paciente: 1234,
      freq: 67,
      peso: 65.3,
      stress: 2,
      desanimo: 1,
      atv_fisica: 1);

  var medida2 = Medicao(
      horario: "2021-11-24 09:45:02Z",
      id_paciente: 1234,
      freq: 70,
      peso: 65.3,
      stress: 3,
      desanimo: 1,
      atv_fisica: 0);

  var medida3 = Medicao(
      horario: "2021-11-25 12:15:04",
      id_paciente: 1234,
      freq: 60,
      peso: 65.0,
      stress: 1,
      desanimo: 0,
      atv_fisica: 1);

  var medida4 = Medicao(
      horario: "2021-12-26 09:25:02",
      id_paciente: 1234,
      freq: 75,
      peso: 65,
      stress: 3,
      desanimo: 3,
      atv_fisica: 0);

  var medida5 = Medicao(
      horario: "2021-11-27 09:19:03",
      id_paciente: 1234,
      freq: 67,
      peso: 65.6,
      stress: 2,
      desanimo: 2,
      atv_fisica: 1);

  var medida6 = Medicao(
      horario: "2021-11-28 14:15:02",
      id_paciente: 1234,
      freq: 76,
      peso: 65.5,
      stress: 3,
      desanimo: 1,
      atv_fisica: 1);

  var medida7 = Medicao(
      horario: "2021-11-29 12:12:02",
      id_paciente: 1234,
      freq: 64,
      peso: 65.2,
      stress: 0,
      desanimo: 0,
      atv_fisica: 1);

  var medida8 = Medicao(
      horario: "2021-11-30 17:14:02",
      id_paciente: 1234,
      freq: 85,
      peso: 64.9,
      stress: 3,
      desanimo: 3,
      atv_fisica: 0);

  var medida9 = Medicao(
      horario: "2021-12-01 09:13:02Z",
      id_paciente: 1234,
      freq: 72,
      peso: 64.9,
      stress: 2,
      desanimo: 2,
      atv_fisica: 1);

  var medida10 = Medicao(
      horario: "2021-12-02 11:13:02Z",
      id_paciente: 1234,
      freq: 69,
      peso: 65.2,
      stress: 1,
      desanimo: 0,
      atv_fisica: 1);

  var medida11 = Medicao(
      horario: "2021-12-03 10:15:32Z",
      id_paciente: 1234,
      freq: 87,
      peso: 65.1,
      stress: 2,
      desanimo: 0,
      atv_fisica: 1);

  var medida12 = Medicao(
      horario: "2021-12-04 11:12:23Z",
      id_paciente: 1234,
      freq: 65,
      peso: 65.3,
      stress: 1,
      desanimo: 1,
      atv_fisica: 0);

  Database db = await getDatabase();

  await db.execute("DROP TABLE IF EXISTS Usuario;");
  await db.execute("DROP TABLE IF EXISTS Medicao;");
  await db.execute("DROP TABLE IF EXISTS Atende;");

  await db.execute(
      'CREATE TABLE Usuario(id INTEGER PRIMARY KEY, nome TEXT NOT NULL, email TEXT NOT NULL, senha TEXT NOT NULL, idade INTEGER NOT NULL, documento TEXT NOT NULL,' +
          'dataNascimento TEXT NOT NULL, altura INTEGER, crm INTEGER, tipoUsuario BIT NOT NULL);');
  await db.execute(
      'CREATE TABLE Medicao(horario TEXT, id_paciente INTEGER, freq INTEGER, peso FLOAT, stress INTEGER, desanimo INTEGER, atv_fisica INTEGER,' +
          'CONSTRAINT pk_medicao primary key(horario,id_paciente),' +
          'CONSTRAINT fk_paciente FOREIGN KEY(id_paciente) REFERENCES Usuario(id));');
  await db.execute('CREATE TABLE Atende(id_profissional INTEGER, id_paciente INTEGER,' +
      'CONSTRAINT pk_atende PRIMARY KEY(id_profissional,id_paciente),' +
      'CONSTRAINT fk_profissional FOREIGN KEY(id_profissional) REFERENCES Usuario(id),' +
      'CONSTRAINT fk_paciente FOREIGN KEY(id_paciente) REFERENCES Usuario(id));');

  await insertUsuario(paulo);
  await insertUsuario(alberto);
  await insertAtende(atendimento);
  await insertMedicao(medida1);
  await insertMedicao(medida2);
  await insertMedicao(medida3);
  await insertMedicao(medida4);
  await insertMedicao(medida5);
  await insertMedicao(medida6);
  await insertMedicao(medida7);
  await insertMedicao(medida8);
  await insertMedicao(medida9);
  await insertMedicao(medida10);
  await insertMedicao(medida11);
  await insertMedicao(medida12);

  print(await usuario());
  print(await atende());
  print(await medicao());
}

class Usuario {
  final int id;
  final String nome;
  final String email;
  final String senha;
  final int idade;
  final String documento;
  final String dataNascimento;
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
      'dataNascimento': dataNascimento,
      'tipoUsuario': tipoUsuario,
    };
  }

  @override
  String toString() {
    return 'Usuario{id: $id, nome: $nome, age: $idade, email: $email, senha: $senha, documento: $documento, ' +
        'dataNascimento: $dataNascimento, altura: $altura, crm: $crm, tipoUsuario: $tipoUsuario}';
  }
}

class Medicao {
  final String horario;
  final int id_paciente;
  final int freq;
  final double peso;
  final int stress;
  final int desanimo;
  final int atv_fisica;

  Medicao({
    required this.horario,
    required this.id_paciente,
    required this.freq,
    required this.peso,
    required this.stress,
    required this.desanimo,
    required this.atv_fisica,
  });

  Map<String, dynamic> toMap() {
    return {
      'horario': horario,
      'id_paciente': id_paciente,
      'freq': freq,
      'peso': peso,
      'stress': stress,
      'desanimo': desanimo,
      'atv_fisica': atv_fisica,
    };
  }

  @override
  String toString() {
    return 'Medicao{horario: $horario, id_paciente: $id_paciente,freq:$freq, peso: $peso, stress: $stress, desanimo: $desanimo, ' +
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

Future<void> insertUsuario(Usuario usuario) async {
  final db = await getDatabase();

  await db.insert(
    'usuario',
    usuario.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> insertMedicao(Medicao medicao) async {
  final db = await getDatabase();

  await db.insert(
    'medicao',
    medicao.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> insertAtende(Atende atende) async {
  final db = await getDatabase();
  await db.insert(
    'atende',
    atende.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Usuario>> usuario() async {
  final db = await getDatabase();

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
  final db = await getDatabase();

  final List<Map<String, dynamic>> maps = await db.query('medicao');

  return List.generate(maps.length, (i) {
    return Medicao(
      horario: maps[i]['horario'],
      id_paciente: maps[i]['id_paciente'],
      freq: maps[i]['freq'],
      peso: maps[i]['peso'],
      stress: maps[i]['stress'],
      desanimo: maps[i]['desanimo'],
      atv_fisica: maps[i]['atv_fisica'],
    );
  });
}

Future<List<Atende>> atende() async {
  final db = await getDatabase();

  final List<Map<String, dynamic>> maps = await db.query('atende');

  return List.generate(maps.length, (i) {
    return Atende(
      id_profissional: maps[i]['id_profissional'],
      id_paciente: maps[i]['id_paciente'],
    );
  });
}

Future<void> updateUsuario(Usuario usuario) async {
  final db = await getDatabase();
  await db.update(
    'usuario',
    usuario.toMap(),
    where: 'id = ?',
    whereArgs: [usuario.id],
  );
}

Future<void> updateMedicao(Medicao medicao) async {
  final db = await getDatabase();
  await db.update(
    'medicao',
    medicao.toMap(),
    where: '(horario,id_paciente) = ?',
    whereArgs: [medicao.horario, medicao.id_paciente],
  );
}

Future<void> deleteUsuario(int id) async {
  final db = await getDatabase();

  await db.delete(
    'usuario',
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<void> deleteMedicao(DateTime horario, int id_paciente) async {
  final db = await getDatabase();

  await db.delete(
    'medicao',
    where: '(horario,id_paciente) = ?',
    whereArgs: [horario, id_paciente],
  );
}

Future<void> deleteAtende(int id_profissional, int id_paciente) async {
  final db = await getDatabase();

  await db.delete(
    'atende',
    where: '(id_profissional,id_paciente) = ?',
    whereArgs: [id_profissional, id_paciente],
  );
}
