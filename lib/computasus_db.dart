import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'computasus.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE Usuario(id INTEGER PRIMARY KEY, nome TEXT NOT NULL, email TEXT NOT NULL, senha TEXT NOT NULL, Documento TEXT NOT NULL,' +
              'data_nascimento DATE NOT NULL, altura INTEGER, crm INTEGER, tipo_usuario BIT NOT NULL) ');
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
      return usuario(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        email: maps[i]['email'],
        senha: maps[i]['senha'],
        documento: maps[i]['documento'],
        data_nascimento: maps[i]['data_nascimento'],
        altura: maps[i]['altura'],
        crm: maps[i]['crm'],
        tipo_usuario: maps[i]['tipo_usuario'],
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
  final String documento;
  final DateTime data_nasciemnto;
  final int altura;
  final String crm;
  final int tipo_usuario;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.senha,
    required this.documento,
    required this.data_nascimento,
    required this.tipo_usuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'email': age,
      'senha': senha,
      'documento': documento,
      'data_nascimento': data_nascimento,
      'tipo_usuario': tipo_usuario,
    };
  }

  @override
  String toString() {
    return 'Usuario{id: $id, npme: $nome, age: $idade, email: $email, senha: $senha, documento: $documento, ' +
        'data_nascimento: $data_nascimento, altura: $altura, crm: $crm, tipo_usuario: $tipo_usuario}';
  }
}
