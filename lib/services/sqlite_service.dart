import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:localpulse/models/event.dart';
import 'package:localpulse/models/user.dart';
import 'package:localpulse/services/random_methods.dart';


class SqliteService {
  static const String databaseName = "database.db";
  static Database? db;

  static Future<Database> initializeDB() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return db?? await openDatabase(
      path, 
      version: 1,       
      onOpen: (Database db) async {
        await createTables(db);
    });
  }
  static Future<void> createTables(Database db) async{
    await db.execute( 
           """
            CREATE TABLE IF NOT EXISTS events(id INTEGER IDENTITY(1,1) PRIMARY KEY,
                name TEXT, description TEXT, latitude TEXT, longitude TEXT,
                date DATE,time TIMESTAMP,userId INT);
            """
          );
          await db.execute( 
           """
            CREATE TABLE IF NOT EXISTS users(id INTEGER IDENTITY(1,1) PRIMARY KEY,
                email TEXT NOT NULL, full_name TEXT NOT NULL, password TEXT NOT NULL);
            """
          );
  }
  static Future<void> deleteTables(Database db) async{
    await db.execute( 
           """
            DROP TABLE events;
            """
          );
          await db.execute( 
           """
            DROP TABLE users;
            """
          );
  }
  static Future<void> insertEvent(Event event, BuildContext context) async {
    final db = await SqliteService.initializeDB();
    await db.insert(
      'events', event.toMap(context), 
      conflictAlgorithm: ConflictAlgorithm.replace);
   }

  static Future<List<Event>> getEvents(Database db) async {
    final db = await SqliteService.initializeDB();

    final List<Map<String, Object?>> queryResult = 
      await db.query('events');
    return queryResult.map((e) => Event.fromMap(e)).toList();
  }  

  static Future<void> insertUser(User user, BuildContext context) async {
    final db = await SqliteService.initializeDB();
    final currentUserOnDb = await db.rawQuery('SELECT * FROM users WHERE email="${user.email}"  ');
    if(currentUserOnDb != null) {
      showDialogWithText(context, "Error", "User with the same email already exists!");
      print("This the user : ${user}");
      throw Error;
    } else {
      await db.insert(
            'users', user.toMap(), 
            conflictAlgorithm: ConflictAlgorithm.replace);
    }
    
  }

  static Future<List<User>> getUsers(Database db) async {
    final db = await SqliteService.initializeDB();

    final List<Map<String, Object?>> queryResult = 
      await db.query('users');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }   

  static Future<bool> isUserOnDb(Database db, String email, String password, BuildContext context) async {
    final db = await SqliteService.initializeDB();

    List<Map> currentUserOnDb = await db.rawQuery('SELECT * FROM users WHERE email="${email}"  ');
    if(currentUserOnDb != null) {
      // print("This is currentUserOnDB : ${currentUserOnDb.first}");
      return true;
      // if(currentUserOnDb.length == 1 && currentUserOnDb.first.password
    } else {
      showDialogWithText(context, "Error", "a User with the same email does not exists!");
      return false;
    }
  } 
}
