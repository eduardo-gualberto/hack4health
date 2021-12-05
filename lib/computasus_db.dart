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
      return db.execute(
          'CREATE TABLE Usuario(id INTEGER PRIMARY KEY, nome TEXT NOT NULL, email TEXT NOT NULL, senha TEXT NOT NULL, idade INTEGER NOT NULL, documento TEXT NOT NULL,' +
              'data_nascimento VARCHAR(20) NOT NULL, altura INTEGER, crm INTEGER, tipo_usuario BIT NOT NULL) ');
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

  Future<void> updateUsuario(Usuario usuario) async {
    final db = await database;
    await db.update(
      'usuario',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
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
