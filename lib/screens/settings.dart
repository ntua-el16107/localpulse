import 'package:localpulse/screens/components.dart';
import 'package:flutter/material.dart';
import 'package:localpulse/screens/edit_profile.dart';
import 'package:localpulse/screens/my_events.dart';


class SettingsWidget extends StatefulWidget{
  const SettingsWidget({Key? key}) : super(key: key);
  @override
  State <SettingsWidget>  createState() => _SettingsWidgetState();
    
}
class _SettingsWidgetState extends State<SettingsWidget>{
  //final _formKey = GlobalKey<FormState>();
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
                  navigator.pop();
                  navigator.push(
                    MaterialPageRoute(builder: (context) => const EditProfileWidget()),
                  );
                },
              ),
                const PopupMenuItem(
                child: ListTile(
                  //selectedColor: Color.fromARGB(221, 114, 151, 164) ,
                  title:  Text('Settings'),
                )),
                 PopupMenuItem(
                child: const ListTile(
                  //selectedColor: Color.fromARGB(221, 114, 151, 164) ,
                  title: Text('Logout'),
                ),
                onTap: () {
                  int count=0;
                  //Navigator.popAndPushNamed(context, '/');
                  Navigator.popUntil(context, (route) => count++ == 2);
                },
              ),
            ]),
            //onSelected: (){},
          )
        ),
      body: Container(
        color: const Color.fromARGB(255, 12, 73, 95),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Logo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                 alignment: const Alignment(30,0),
                  //padding: EdgeInsets.all(8.0),
                  height: 120,
                  width: 180,
                  decoration: const BoxDecoration(
                    color:  Color.fromARGB(255, 12, 73, 95),  
                  ),
                  child: const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Settings", 
                      style: TextStyle(  
                        fontFamily: 'ChauPhilomeneOne',
                        letterSpacing: 5.0,
                        color:Color.fromARGB(200, 255, 255, 255), 
                        fontSize: 40, 
                        //fontWeight: FontWeight.bold
                      )
                    )
                  )
                )
              ]
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:   [
                  //Spacer(),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: const Text(
                      'Auto Mode',
                      style:  TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(185, 255, 255, 255)
                      ),
                    ),
                  ),
                  const AutoMode(),
                  //Spacer()
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
               // top: MediaQuery.of(context).size.height * 0.1,
                bottom: MediaQuery.of(context).size.height * 0.1, 
                left: MediaQuery.of(context).size.height * 0.1,
                right: MediaQuery.of(context).size.height * 0.1),
             // child: Form(
               // key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    
                    Padding(
                      padding: const EdgeInsets.all(20),

                      child: TextButton(

                         //padding: EdgeInsets.zero,
                        child: Container(
                          width:MediaQuery.of(context).size.width,
                          height: 40,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(149, 18, 109, 142),
                                Color.fromARGB(249, 20, 117, 152),
                              ]
                            )
                          ),
                          child: const Center(child: Text("Norification Center", style: TextStyle(color:Color.fromARGB(200, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.w800),)),
                        ),
                        onPressed: (){}// => Navigator.pop(context,true)
                      ),
                    ),
                                  /*if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                  }*/
                                
                              //),
                           // ),
                            //),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20, ),
                      child: TextButton(
                        //padding: EdgeInsets.zero,
                        child: Container(
                          width:MediaQuery.of(context).size.width,
                            height: 40,
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(149, 18, 109, 142),
                                    Color.fromARGB(249, 20, 117, 152),
                                  ]
                                )
                              ),
                              child: const Center(child: Text("Terms and Conditions", style: TextStyle(color:Color.fromARGB(200, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.w800),)),
                        ),
                        onPressed: () {}
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),

                      child: TextButton(

                         //padding: EdgeInsets.zero,
                        child: Container(
                          width:MediaQuery.of(context).size.width,
                          height: 40,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(149, 18, 109, 142),
                                Color.fromARGB(249, 20, 117, 152),
                              ]
                            )
                          ),
                          child: const Center(child: Text("Home Page", style: TextStyle(color:Color.fromARGB(200, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.w800),)),
                        ),
                        onPressed: (){
                          Navigator.of(context).pop();
                        }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),

                      child: TextButton(

                         //padding: EdgeInsets.zero,
                        child: Container(
                          width:MediaQuery.of(context).size.width,
                          height: 40,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(149, 18, 109, 142),
                                Color.fromARGB(249, 20, 117, 152),
                              ]
                            )
                          ),
                          child: const Center(child: Text("Logout", style: TextStyle(color:Color.fromARGB(200, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.w800),)),
                        ),
                        onPressed: (){
                          int count=0;
                           Navigator.popUntil(context, (route) => count++ == 2);
                        }
                      ),
                    ),
                                
                  ]
                )
              ),
       //     )
          ],
        ),
      ),
    );
  }
}