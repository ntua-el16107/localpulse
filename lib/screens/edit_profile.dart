import 'package:localpulse/screens/components.dart';
import 'package:flutter/material.dart';
import 'package:localpulse/screens/my_events.dart';
import 'package:localpulse/screens/settings.dart';
//import 'package:localpulse/main.dart';

class EditProfileWidget extends StatefulWidget{
  const EditProfileWidget({Key? key}) : super(key: key);
  @override
  State <EditProfileWidget>  createState() => _EditProfileWidgetState();
 //_EditProfileWidgetState createState() => _EditProfileWidgetState();
    
}
class _EditProfileWidgetState extends State<EditProfileWidget>{
  final _formKey = GlobalKey<FormState>();
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
                const PopupMenuItem( 
                  child: ListTile(
                    //selectedColor: Color.fromARGB(221, 114, 151, 164) ,
                    title: Text('Edit Profile'),
                  ),
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
                  width: 150,
                  decoration: const BoxDecoration(
                    color:  Color.fromARGB(255, 12, 73, 95),  
                  ),
                  child: const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "User Details", 
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
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1, 
                left: MediaQuery.of(context).size.height * 0.1,
                right: MediaQuery.of(context).size.height * 0.1),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      style: const TextStyle(color: Colors.white70),
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      decoration:  const InputDecoration(
                        fillColor: Colors.white70,
                        icon: Icon(Icons.person_2, size: 25,color:Colors.white54),
                        contentPadding: EdgeInsets.only(left:10),
                        hintText: "Tom Brown",
                        labelText: "Full Name",
                        labelStyle: TextStyle(color:Colors.white70, fontSize: 12, fontWeight: FontWeight.w500 ),
                        hintStyle: TextStyle(color:Colors.white38, fontSize: 18, fontWeight: FontWeight.w500 )
                       )
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white70),
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email, size: 25, color: Colors.white70),
                        contentPadding: EdgeInsets.only(left:10),
                        hintText: "tombrown@gmail.com",
                        hintStyle: TextStyle(color:Colors.white38, fontSize: 18, fontWeight: FontWeight.w500 ),
                        labelText: "Email",
                        labelStyle: TextStyle(color:Colors.white70, fontSize: 12, fontWeight: FontWeight.w500 ),
                      ),
                      maxLines: 1,
                    ),
                    TextFormField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      style: const TextStyle(color: Colors.white70),
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.key, size: 25, color: Colors.white70),
                        contentPadding: EdgeInsets.only(left:10),
                        labelText: "Password",
                        labelStyle: TextStyle(color:Colors.white70, fontSize: 12, fontWeight: FontWeight.w500 ),
                      ),
                      maxLines: 1,
                    ),
                    TextFormField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      style: const TextStyle(color: Colors.white70),
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.key, size: 25, color: Colors.white70),
                        contentPadding: EdgeInsets.only(left:10),
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color:Colors.white70, fontSize: 12, fontWeight: FontWeight.w500 ),
                      ),
                      maxLines: 1,
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
                          child: const Center(child: Text("Submit", style: TextStyle(color:Color.fromARGB(200, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.w800),)),
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
                      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
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
                              child: const Center(child: Text("Cancel", style: TextStyle(color:Color.fromARGB(200, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.w800),)),
                        ),
                        onPressed: () => Navigator.pop(context,true)
                      ),
                    ),
                                
                  ]
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}