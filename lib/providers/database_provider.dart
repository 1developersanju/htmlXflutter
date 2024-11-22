import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/db_helper.dart';

class DatabaseProvider with ChangeNotifier {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await DBHelper().database;
    return _database;
  }
}
