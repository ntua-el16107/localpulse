import 'package:flutter/services.dart';
import 'package:localpulse/screens/components.dart';
import 'package:localpulse/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:localpulse/screens/sign_up.dart';
//import 'package:localpulse/edit_profile.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:localpulse/services/sqlite_service.dart';



void main() async {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        title: 'Local Pulse',
        theme: ThemeData(
          //primarySwatch: Colors.whit
        ),
        /*initialRoute: '/',
        routes: {
          '/':(context) => const SignInWidget(),
          '/editprofile':(context) => const EditProfileWidget(),
          '/homepage': (context) => const HomePage()
        },
        */        home: const SignInWidget(),//HomePage(),
        debugShowCheckedModeBanner: false);
  }
}



class SignInWidget extends StatefulWidget{
  const SignInWidget({Key? key}) : super(key: key);
  @override
  State <SignInWidget> createState() => _SignInWidgetState(); 
  //_SignInWidgetState createState() =>  _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget>{
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailFormController = TextEditingController();
  TextEditingController passwordFormController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Container(
        color: const Color.fromARGB(255, 12, 73, 95),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const  Logo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: const Alignment(30,0),
                  height: 120,
                  width: 150,
                  decoration: const BoxDecoration(
                    color:  Color.fromARGB(255, 12, 73, 95),                     
                  ),
                  child: const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Sign In",
                      style: TextStyle(
                        fontFamily: 'ChauPhilomeneOne',
                        letterSpacing: 5.0,
                        color: Color.fromARGB(200, 255, 255, 255),
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ]  ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: const Alignment(30,0),
                  height: 50,
                  width: 280,
                  decoration: const BoxDecoration(
                    color:  Color.fromARGB(255, 12, 73, 95),                     
                  ),
                  child: const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Sign in and descover local events!",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: Color.fromARGB(200, 255, 255, 255),
                        //fontSize: 10,
                      ),
                    ),
                  ),
                )
              ]  ,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.1, 
                left: MediaQuery.of(context).size.height * 0.1,
                right: MediaQuery.of(context).size.height * 0.1
                ),
              child: SingleChildScrollView (
                child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: emailFormController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid email';
                        } else {
                          final bool emailValid = 
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                          if(!emailValid) {
                            return 'Please enter a valid email';
                          }
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white70),
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      decoration:  const InputDecoration(
                        fillColor: Colors.white70,
                        icon: Icon(Icons.email, size: 25,color:Colors.white54),
                        contentPadding: EdgeInsets.only(left:10),
                        labelText: "Email",
                        labelStyle: TextStyle(color:Colors.white70, fontSize: 12, fontWeight: FontWeight.w500 ),
                      )
                    ),
                    TextFormField(
                      controller: passwordFormController,
                      validator : (value) {
                        RegExp regex =
                            RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
                        if (value == null) {
                          return 'Please enter password';
                        } else {
                          if (!regex.hasMatch(value)) {
                            return 'Password Must contain Digit, Lowercase and Uppercase.';
                          } else {
                            return null;
                          }
                        }
                      },
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
                    Row(
                      children: const [
                        Padding( //Checkbox
                          padding: EdgeInsets.fromLTRB( 0.0,  5.0, 0.0, 5.0), //, top: 20.0, bottom: 20,0),
                          child: TikBox(),
                        ),
                        Padding(//Remember me 
                          padding:  EdgeInsets.only(right: 00.0),
                          child: SizedBox( //Container(
                            //width:MediaQuery.of(context).size.width,
                            height: 30,            
                            child:  Center(
                              child: Text(
                                "Remember me", 
                                style: TextStyle(
                                  color:Color.fromARGB(200, 255, 255, 255), 
                                  fontSize: 13, 
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        )
                      ]
                    ),
                         Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                            child: TextButton(
                              child: const Center(
                                child: Text(
                                  "Forgot Password?", 
                                  style: TextStyle(
                                    color:Color.fromARGB(200, 255, 255, 255), 
                                    fontSize: 13, 
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                              ),
                              onPressed: () {},
                              ),
                            )
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
                          child: const Center(child: Text("Sign In", style: TextStyle(color:Color.fromARGB(200, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.w800),)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) { 
                            var db = await SqliteService.initializeDB();
                            var found = await SqliteService.isUserOnDb(db, emailFormController.text, passwordFormController.text, context);
                            
                            if(found == true) {
                              print("TRUEEE!");
                              final navigator = Navigator.of(context);
                            await Future.delayed(Duration.zero);
                            //save ta stoixeia eisodou  
                            navigator.push(
                              MaterialPageRoute(builder: (_) => const HomePage()),
                            );
                            }
                          
                          }//Navigator.of(context).pushNamed('/homepage');
                        }
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
                              child: const Center(child: Text("Sign Up", style: TextStyle(color:Color.fromARGB(200, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.w800),)),
                        ),
                        onPressed: ()async{
                          
                            final navigator = Navigator.of(context);
                              await Future.delayed(Duration.zero);
                              //save ta stoixeia eisodou  
                              navigator.push(
                                MaterialPageRoute(builder: (_) => const SignUpWidget()),
                              );
                            //Navigator.of(context).pushNamed('/homepage');
                          
                    
                        }
                      ),
                    ),
                    
                  ]
                ),
                
              
                )),
              ),
          ]
        ),
      )    
    );  
  }
}