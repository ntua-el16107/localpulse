import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:latlong2/latlong.dart';
import 'package:localpulse/models/event.dart';
import 'package:localpulse/services/sqlite_service.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default


TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat.jm(); //"6:00 AM"
  return TimeOfDay.fromDateTime(format.parse(tod));
}

Future<void> showAlertDialog(BuildContext context){
  return showDialog(
    context: context, 
    builder: (context){
      return const AlertDialog(
        title: Text('Something went wrong!'),
        actions: [
           Text("Check your input. Maybe the address is incorrect!")        
          ],
      );
    }
    );
}

Future<void> showEventCreationDialog(BuildContext context){
  return showDialog(
    context: context, 
    builder: (context){
      return const AlertDialog(
        title: Text('Event Submitted Successfully!'),
        actions: [
           Text("Congratulations!")        
          ],
      );
    }
    );
}

Future<void> showDialogWithText(BuildContext context, String titleText, String mainText){
  return showDialog(
    context: context, 
    builder: (context){
      return  AlertDialog(
        title: Text(titleText),
        actions: [
           Text(mainText)        
          ],
      );
    }
    );
}
Future<LatLng> getAddress(value, context) async {
  try {
    var addresses = await Geocoder.local.findAddressesFromQuery(value);
    var first = addresses.first;
    print("${first.featureName} : ${first.coordinates}");
    var latitude = first.coordinates.latitude;
    var longitude = first.coordinates.longitude;
    LatLng latLng = LatLng(latitude!, longitude!);
    print("This is LatLng ${latLng}");
    return latLng;
  } catch(exception) {
    print("caught it!");
    showAlertDialog(context);
    return LatLng(0, 0);
  }
}

// Future<List<Event>>? getTheEvents() {
//   var eventList = [];
//   SqliteService.initializeDB().then((value) => {
//      eventList = SqliteService.getEvents().then();
//   });
// }


LatLng stringToLatLng(String text) {
  print("This the text we are trying to convert from string to latlng : ${text}");
  List<String> latlong =  text.split(",");
  double _latitude = double.parse(latlong[0]);
  double _longitude = double.parse(latlong[1]);
  return LatLng(_latitude, _longitude);
}


Future<void> addMarkers(List<Marker> markers) async {
 SqliteService.initializeDB().then((value) => {
    SqliteService.getEvents(value).then((eventList) {
    print("This is eventList : ${eventList}");
    eventList.forEach((element) {
      markers.add( Marker(
          width: 80,
          height: 80,
          point: LatLng(double.parse(element.latitude), double.parse(element.longitude)),
          builder: (ctx) => const Icon(Icons.event),
          )
        );
      }
    );
  }) 
  
 }); 
}
  // Geocoder.local.findAddressesFromQuery(value).then((val) {
  //   var first = val.first;
  //   print("${first.featureName} : ${first.coordinates}");
  //   var latitude = first.coordinates.latitude;
  //   var longitude = first.coordinates.longitude;
  //   LatLng latLng = LatLng(latitude!, longitude!);
  //   print("This is LatLng ${latLng}");
  // }).catchError(
  //   (Object e, StackTrace stackTrace) {
  //     print("CAUGHT THE RORRORORORO;");
  //     return null;
  //   }
  // ).then(print);