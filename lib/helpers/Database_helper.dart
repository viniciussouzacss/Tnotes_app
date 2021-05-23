import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tnotes_app/models/Note_model.dart';
import 'package:tnotes_app/models/Task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();

  // Tables
  String tasksTable = 'task_table';
  String notesTable = 'note_table';

  // Columns
  String colId = 'id';
  String colTitle = 'title';
  String colText = 'text';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

// Task Table
// Id | Title | Date | Priority | Status
// 0     ''      ''       ''         0
// 1     ''      ''       ''         0
// 2     ''      ''       ''         0

// Note Table
// Id | Title | Text
// 0     ''      ''
// 1     ''      ''
// 2     ''      ''

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }

    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'tnotes.db';
    final tnotesDb = await openDatabase(path,
        version: 2, onCreate: _createDb, onUpgrade: _upgradeDb);
    return tnotesDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $tasksTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDate TEXT, $colPriority TEXT, $colStatus INTEGER)',
    );
    await db.execute(
      'CREATE TABLE $notesTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colText TEXT)',
    );
  }

  void _upgradeDb(Database db, int oldVersion, int version) async {}

  // Get MapList

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(tasksTable);
    return result;
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(notesTable);
    return result;
  }

  // Get List

  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(Task.fromMap(taskMap));
    });
    taskList.sort((taskA, taskB) => taskA.date.compareTo(taskB.date));
    return taskList;
  }

  Future<List<Note>> getNoteList() async {
    final List<Map<String, dynamic>> noteMapList = await getNoteMapList();
    final List<Note> noteList = [];
    noteMapList.forEach((noteMap) {
      noteList.add(Note.fromMap(noteMap));
    });
    return noteList;
  }

  // Insert

  Future<int> insertTask(Task task) async {
    Database db = await this.db;
    final int result = await db.insert(tasksTable, task.toMap());
    return result;
  }

  Future<int> insertNote(Note note) async {
    Database db = await this.db;
    final int result = await db.insert(notesTable, note.toMap());
    return result;
  }

  // Update

  Future<int> updateTask(Task task) async {
    Database db = await this.db;
    final int result = await db.update(
      tasksTable,
      task.toMap(),
      where: '$colId = ?',
      whereArgs: [task.id],
    );
    return result;
  }

  Future<int> updateNote(Note note) async {
    Database db = await this.db;
    final int result = await db.update(
      notesTable,
      note.toMap(),
      where: '$colId = ?',
      whereArgs: [note.id],
    );
    return result;
  }

  // Delete

  Future<int> deleteTask(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      tasksTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      notesTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }
}
