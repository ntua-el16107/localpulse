import 'package:flutter/material.dart';
import 'package:localpulse/models/event.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:localpulse/services/random_methods.dart';
import 'package:localpulse/services/sqlite_service.dart';
import 'package:path/path.dart';
import 'package:latlong2/latlong.dart';



//To LOGO ως έχει
class Logo extends StatelessWidget {
  const Logo({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              //padding: EdgeInsets.all(8.0),
              height: 80,
              width: 120,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 12, 73, 95),
              ),
              child: const Center(
                  child: Text(
                      textAlign: TextAlign.center,
                      "LOCAL PULSE",
                      style: TextStyle(
                        fontFamily: 'Gluten',
                        color: Color.fromARGB(200, 255, 255, 255),
                        fontSize: 35,
                        //fontWeight: FontWeight.bold
                      ))))
        ]);
  }
}

//Το Checkbox
class TikBox extends StatefulWidget {
  const TikBox({super.key});

  @override
  State<TikBox> createState() => _TikBoxState();
}

class _TikBoxState extends State<TikBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return const Color.fromARGB(255, 20, 118, 154);
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

enum Auto { enabled, disabled }

//seqmented button auto mode
class AutoMode extends StatefulWidget {
  const AutoMode({super.key});

  @override
  State<AutoMode> createState() => _AutoModeState();
}

class _AutoModeState extends State<AutoMode> {
  Auto autoView = Auto.disabled;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        // MaterialState.pressed,
        MaterialState.hovered,
        //MaterialState.focused,
      };
      const Set<MaterialState> testStates = <MaterialState>{
        MaterialState.pressed,
        //MaterialState.hovered,
        MaterialState.focused,
        MaterialState.selected
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white38;
      }
      if (states.any(testStates.contains)) {
        return const Color.fromARGB(249, 20, 117, 152);
      }
      return const Color.fromARGB(255, 12, 73, 95);
    }

    return SegmentedButton<Auto>(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(getColor),
      ),
      segments: const <ButtonSegment<Auto>>[
        ButtonSegment<Auto>(
            value: Auto.enabled,
            label: Text(
              style: TextStyle(
                color: Colors.white,
              ),
              'On',
              selectionColor: Colors.white,
            ),
            icon: Icon(Icons.drive_eta, color: Colors.white60)),
        ButtonSegment<Auto>(
            value: Auto.disabled,
            label: Text(
              'Off',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(Icons.drive_eta, color: Colors.white60)),
      ],
      selected: <Auto>{autoView},
      onSelectionChanged: (Set<Auto> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          autoView = newSelection.first;
        });
      },
    );
  }
}

//floating add event button

class AddEvent extends StatelessWidget {
  AddEvent({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameFormController = TextEditingController();
  TextEditingController descriptionFormController = TextEditingController();
  TextEditingController addressFormController = TextEditingController();
  TextEditingController dateFormController = TextEditingController();
  TextEditingController timeFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Add event',
      backgroundColor: const Color.fromARGB(255, 3, 7, 30),
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
            barrierColor: const Color.fromARGB(93, 0, 0, 0),
            context: context,
            builder: (BuildContext context) {
              //_showOverlay(context);
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      color: const Color.fromARGB(255, 12, 73, 95),
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.1),
                      //width: MediaQuery.of(context).size.width * 0.8,
                      //height: MediaQuery.of(context).size.height * 0.8,

                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                                controller: nameFormController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a name for the event';
                                  }
                                  return null;
                                },
                                style: const TextStyle(color: Colors.white70),
                                keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                minLines: 1,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white70,
                                    icon: Icon(Icons.person,
                                        size: 25, color: Colors.white54),
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: "Enter Event's Name",
                                    labelText: "Event Name",
                                    labelStyle: TextStyle(
                                        color: Colors.white38,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    hintStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500))),
                            TextFormField(
                              controller: descriptionFormController,
                              validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a description for the event';
                                  }
                                  return null;
                                },
                              style: const TextStyle(color: Colors.white70),
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.description,
                                    size: 25, color: Colors.white70),
                                contentPadding: EdgeInsets.only(left: 10),
                                hintText: "Description",
                                hintStyle: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                                labelText: "Enter the Event's description",
                                labelStyle: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              maxLines: 10,
                              minLines: 5,
                            ),
                            TextFormField(
                                controller: addressFormController,
                                validator: (value)  {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a address for the event';
                                  }
                                  
                                 
                                  return null;
                                },
                                style: const TextStyle(color: Colors.white70),
                                keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                minLines: 1,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.location_pin,
                                        size: 25, color: Colors.white70),
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintStyle: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                    hintText: "Location",
                                    labelText: "Enter the Event's address",
                                    labelStyle: TextStyle(
                                        color: Colors.white38,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500))),
                            TextFormField(
                                controller: dateFormController,
                                validator: (value) {
                                  try {
                                    if(value == null || DateTime.tryParse(value) == null) {
                                      throw Error();
                                    } else {
                                      var date = DateTime.parse(value);
                                      
                                      if(date.isBefore(DateTime.now().subtract(const Duration(days:1)))) {
                                        return "Date cannot be in the past";
                                      }
                                    }
                                    return null;
                                  } catch (e) {
                                    return "Please enter a valid date";
                                  }
                                },
                                style: const TextStyle(color: Colors.white70),
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    icon: IconButton(
                                        onPressed: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime
                                                      .now(), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101));
                                          if (pickedDate != null) {
                                           dateFormController.text =
                                                pickedDate.toString();
                                          }
                                        },
                                        icon: const Icon(Icons.date_range,
                                            size: 25, color: Colors.white70)),
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                    hintStyle: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                    hintText: "Date",
                                    labelStyle: const TextStyle(
                                        color: Colors.white38,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    labelText: "mm/dd/yyyy")),
                            TextFormField(
                                controller: timeFormController,
                                validator: (value) {
                                  try {
                                    if(value != null) {
                                      var tod = stringToTimeOfDay(value);
                                    }
                                    return null;
                                  } catch (e) {
                                    return "Please enter a valid time";
                                  }
                                },
                                style: const TextStyle(color: Colors.white70),
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    icon: IconButton(
                                      onPressed: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                        );
                                        if (pickedTime != null) {
                                          timeFormController.text =
                                              pickedTime.format(context);
                                        }
                                      },
                                      icon: const Icon(Icons.alarm,
                                          size: 25, color: Colors.white70),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                    labelStyle: const TextStyle(
                                        color: Colors.white38,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    hintStyle: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                    hintText: "Time",
                                    labelText: "Enter the Event's time")),
                            Row(children: [
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(00.0),
                                    child: TextButton(
                                        //padding: EdgeInsets.zero,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                              //borderRadius: BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                Color.fromARGB(
                                                    149, 18, 109, 142),
                                                Color.fromARGB(
                                                    249, 20, 117, 152),
                                              ])),
                                          child: const Center(
                                              child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    200, 255, 255, 255),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                          )),
                                        ),
                                        onPressed: () =>
                                            Navigator.pop(context, true)),
                                  )),

                              /*if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                  }*/

                              //),
                              // ),
                              //),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(00.0),
                                    child: TextButton(
                                      //padding: EdgeInsets.zero,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                              Color.fromARGB(149, 18, 109, 142),
                                              Color.fromARGB(249, 20, 117, 152),
                                            ])),
                                        child: const Center(
                                          child: Text(
                                            "Submit",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    200, 255, 255, 255),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        // do checks if fields not null & valid
                                          if (_formKey.currentState!.validate()) {
                                          // If the form is valid, display a snackbar. In the real world,
                                          // you'd often call a server or save the information in a database.
                                            try {
                                              var latLng = await getAddress(addressFormController.text, context);

                                              var frido = Event(
                                                name: nameFormController.text,
                                                description: descriptionFormController.text,
                                                latitude: latLng.latitude.toString(),
                                                longitude: latLng.longitude.toString(),
                                                date: DateUtils.dateOnly(DateTime.parse(dateFormController.text)),
                                                // time: stringToTimeOfDay(timeFormController.text),]
                                                time: timeFormController.text,
                                                userId: 2112
                                              );

                                              // we create an event object and 
                                              // now we will try to insert into the db
                                              var db = await SqliteService.initializeDB();
                                              await SqliteService.createTables(db);
                                              await SqliteService.insertEvent(frido, context);
                                              print("inserted into the db");
                                              var eventList = await SqliteService.getEvents(db);
                                              print(eventList);
                                              showEventCreationDialog(context);
                                            } catch(_) {
                                              showAlertDialog(context);
                                            }

                                          } else {
                                            showAlertDialog(context);
                                          }
                                       },
                                    ),
                                  ))
                            ])
                          ],
                        ),
                      ))));
            });
      },
    );
  }
}
