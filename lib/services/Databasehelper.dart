
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:ytube_search/models/Curl.dart';
import 'package:ytube_search/models/Curl.dart';



class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String curlTable = 'Curl_table';
  String colId = 'id';
  String colCid = 'cid';
  String colURL = 'URL';
  String colFirstDate = 'firstDate';
  String colRecentDate = 'recentDate';
  String colSearches='searches';


  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    print('in constructor');

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    print('in get db');

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    print('initializeDatabase');
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.toString());
    String path = directory.path + 'curls.db';
    print("$path");

    // Open/create the database at a given path
    var Database = await openDatabase(path, version: 1, onCreate: _createDb);
    print('open db complete');
    return Database;
  }

  Future<Database> deletedb() async {
    print('deleteDatabase');
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    print(directory.toString());
    String path = directory.path + 'curls.db';
    await deleteDatabase(path);
    // Open/create the database at a given path

    var Database = await openDatabase(path, version: 1, onCreate: _createDb);
    print('open db complete');
    return Database;
  }

  void _createDb(Database db, int newVersion) async {
    print('_createDb');

    await db.execute('CREATE TABLE $curlTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colCid TEXT, '
        '$colURL TEXT, $colFirstDate TEXT,$colSearches TEXT, $colRecentDate TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getcurlMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(curlTable, orderBy: '$colFirstDate ASC'); ///************
    return result;
  }


  Future<int> insertCurl (Curl curl) async {
    Database db = await this.database;
    List<Curl> x= await _databaseHelper.getcurlList();

    for (Curl m in x)
      {
        if(m.cid==curl.cid)
          {
            var result = await db.update(curlTable, curl.toMap(), where: '$colCid = ?', whereArgs: [curl.cid]);
            return result;
          }
      }

    var result = await db.insert(curlTable, curl.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateCurl (Curl curl) async {
    var db = await this.database;
    var result = await db.update(curlTable, curl.toMap(), where: '$colCid = ?', whereArgs: [curl.cid]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteCurl (int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $curlTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $curlTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Curl>> getcurlList() async {

    var curlMapList = await getcurlMapList(); // Get 'Map List' from database
    int count = curlMapList.length;         // Count the number of map entries in db table

    List<Curl> curlList = List<Curl>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      curlList.add(Curl.fromMapObject(curlMapList[i]));
    }

    return curlList;
  }

}

