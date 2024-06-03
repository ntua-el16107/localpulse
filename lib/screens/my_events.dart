import 'package:localpulse/screens/components.dart';
import 'package:flutter/material.dart';
import 'package:localpulse/screens/edit_profile.dart';
import 'package:localpulse/screens/settings.dart';



class MyEventsWidget extends StatefulWidget{
  const MyEventsWidget({Key? key}) : super(key: key);
  @override
  State <MyEventsWidget>  createState() => _MyEventsWidgetState();
    
}
class _MyEventsWidgetState extends State<MyEventsWidget>{
 @override
  Widget build(BuildContext context){
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: PopupMenuButton<int>(
            shadowColor: const Color.fromARGB(255, 12, 73, 95),
            //elevation: 1,
            iconSize: 2,
            icon:     Image.asset('assets/Icons/Variant2.png'),// image for profile
            itemBuilder: ((context) => <PopupMenuEntry<int>>[
              PopupMenuItem(
                child: const ListTile(
                  //selectedColor: Color.fromARGB(221, 114, 151, 164) ,
                  title: Text('Events'),
                ),
                onTap :() async {
                  final navigator = Navigator.of(context);
                  await Future.delayed(Duration.zero);
                  navigator.pop();
                  navigator.push(
                    MaterialPageRoute(builder: (context) => const MyEventsWidget()),
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
                  navigator.pop();
                  navigator.push(
                    MaterialPageRoute(builder: (context) => const EditProfileWidget()),
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
                  navigator.pop();
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
                onTap: () {
                  int count=0;
                  Navigator.popUntil(context, (route) => count++ == 2);
                },
              ),
            ]
            ),
            //onSelected: (){},
          )
      ),
      floatingActionButton: AddEvent(),
      body: Container(
        color: const Color.fromARGB(255, 12, 73, 95),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
             Logo(),
          ]
        )
      )
    );
  }
}