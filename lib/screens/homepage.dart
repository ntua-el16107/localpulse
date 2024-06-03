//import 'dart:developer';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localpulse/screens/components.dart';
import 'package:localpulse/screens/edit_profile.dart';
import 'package:localpulse/screens/settings.dart';
import 'package:localpulse/screens/my_events.dart';
import 'package:localpulse/models/event.dart';
import 'package:localpulse/services/random_methods.dart';
import 'package:localpulse/services/sqlite_service.dart';



MapController _mapController = MapController();
LatLng centerLatLng = LatLng(37.983810,  23.727539);


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
 // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    // SqliteService.initializeDB().then(((value) => SqliteService.deleteTables(value)));
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          //leading: ,
          actions: [
            IconButton(
              onPressed: (null), 
              icon: Image.asset('assets/Icons/Photo camera.png'),
              iconSize: 48.0,
              tooltip: 'Camera',
              ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: PopupMenuButton<int>(
            elevation: 1,
            iconSize: 2,
            icon:     Image.asset('assets/Icons/Variant2.png'),// image for profile
            itemBuilder: ((context) => <PopupMenuEntry<int>>[
              PopupMenuItem(
                child: const ListTile(
                  //tileColor: Color.fromARGB(255, 12, 73, 95),
                  //selectedColor: Color.fromARGB(221, 114, 151, 164) ,
                  title: Text('Events'),
                ),
                onTap :() async {
                    final navigator = Navigator.of(context);
                    await Future.delayed(Duration.zero);
                    navigator.push(
                       MaterialPageRoute(builder: /*(_)*/(context) => const MyEventsWidget()),
                    );
                  },
              ),
              PopupMenuItem( 
                child: const ListTile(
                  //selectedColor: Color.fromARGB(221, 114, 151, 164) ,
                  title: Text('Edit Profile'),
                ),
                onTap :() async {
                  final navigator = Navigator.of(context);
                  await Future.delayed(Duration.zero);
                  navigator.push(
                     MaterialPageRoute(builder: /*(_)*/(context) => const EditProfileWidget()),
                  );
                },
                    
                  
              ),
                 PopupMenuItem(
                  child: const ListTile(
                    //selectedColor: Color.fromARGB(221, 114, 151, 164) ,
                    title:  Text('Settings'),
                  ),
                  onTap :() async {
                    final navigator = Navigator.of(context);
                    await Future.delayed(Duration.zero);
                    navigator.push(
                       MaterialPageRoute(builder: (context) => const SettingsWidget()),
                    );
                  },
                ),
                PopupMenuItem(
                  child: const ListTile(
                    //selectedColor: Color.fromARGB(221, 114, 151, 164) ,
                    title: Text('Logout'),
                  ),
                  onTap :() async{
                    //Navigator.popAndPushNamed(context, '/');
                    Navigator.of(context).pop();
                  }
                ),
            ]),
            //onSelected: (){},
          )
        ),
      floatingActionButton: AddEvent(),
      
      body: const HomePageMap(),
    );
  }
}

class HomePageMap extends StatefulWidget {
  const HomePageMap({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageMapState();
}

class _HomePageMapState extends State<HomePageMap> {
  final markers = <Marker>[];
  @override
  void initState() {
    super.initState();
    addMarkers(markers);
    PositionMethods._getCurrentPosition()
        .then((_) => _mapController.move(centerLatLng, 12));
  }

  

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        options: MapOptions(
          center: LatLng(centerLatLng.latitude, centerLatLng.longitude),
          zoom: 9.2,
        ),
        mapController: _mapController,
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.localpulse.app',

          ),
          MarkerLayer(
                    markers: markers,
                    
                  )
        ]);
  }
}

class PositionMethods {
  static Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (hasPermission == false) return;
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((Position position) {
      centerLatLng = LatLng(position.latitude, position.longitude);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  static Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}
