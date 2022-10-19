// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "database_name.db");
    print("Database created Initialized................................");
    Database _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    rint("Database created ................................");
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    var fido = const Dog(
      id: 0,
      name: 'Fido',
      age: 35,
    );
    db.execute(
      'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
    );
    print("Table created................................");
    db.insert(
      'dogs',
      fido.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Data Ingested created................................");
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    List.generate(maps.length, (i) {
      print(maps[i]['id'].toString());
      print(maps[i]['name'].toString());
      print(maps[i]['age'].toString());
    });
  }
}

Future sqfliteIngect() async {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  await _databaseHelper.initDb();
}

class Dog {
  final int id;
  final String name;
  final int age;

  const Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
