import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/message.dart';
import '../utils/db_helper.dart';

class MessageProvider with ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  Future<void> fetchMessages() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db!.query('messages');

    _messages = List.generate(maps.length, (i) {
      return Message.fromMap(maps[i]);
    });

    notifyListeners();
  }

  Future<void> addMessage(Message message) async {
    final db = await DBHelper().database;

    await db!.insert(
      'messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    _messages.add(message);
    notifyListeners();
  }
}
