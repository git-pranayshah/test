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
    Database _db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute('CREATE TABLE todos (id INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' item_name TEXT,'
        ' date_created TEXT');
  }
}

Future sqfliteIngect() async {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  await _databaseHelper.initDb();
}
