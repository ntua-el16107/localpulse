import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:path/path.dart';
import 'package:localpulse/services/random_methods.dart';

class Event {
  String name;
  String? description;
  String latitude;
  String longitude;
  DateTime date;
  String time;
  int userId;

  Event({
      required this.name,
      required this.description,
      required this.latitude,
      required this.longitude,
      required this.date,
      required this.time,
      required this.userId,
   });
  
  
  Event.fromMap(Map<String, dynamic> item): 
    name=item["name"], description= item["description"],
    latitude=item["latitude"], longitude=item["longitude"], date= DateTime.parse(item["date"]),
    // time= stringToTimeOfDay(item["time"]), 
    time= item["time"], userId= item["userId"];

   Map<String, dynamic> toMap(BuildContext context) {
    return {
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,      
      'date': date.toString(),
      'time': time,
      'userId': userId
    };
  }

  @override
  String toString() {
    String strDate = date.toString();
    String strTime = time.toString();

    return 'Event{name: $name, description: $description, latitude: $latitude, longitude: $longitude, date: $strDate, time: $strTime, userId: $userId}';
  }
}



Future<List<Event>> getAllEvents(final database) async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('events');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Event(
      name: maps[i]['name'],
      description:  maps[i]['description'],
      latitude:  maps[i]['latitude'],
      longitude:  maps[i]['longitude'],
      date:  maps[i]['date'],
      time:  maps[i]['time'],
      userId:  maps[i]['userId'],
    );
  });
}