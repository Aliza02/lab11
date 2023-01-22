import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const studentinfo(),
    );
  }
}

class studentinfo extends StatefulWidget {
  const studentinfo({super.key});

  @override
  State<studentinfo> createState() => studentinfoState();
}

class studentinfoState extends State<studentinfo> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController rollnocontroller = new TextEditingController();
  String name = '';
  String rollno = '';

  void addstudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        name = ((prefs.getString('name') ?? namecontroller.text));
        rollno = ((prefs.getString('rollno') ?? rollnocontroller.text));
        prefs.setString('rollno', rollno);
        prefs.setString('name', name);
      },
    );
  }

  void deletestudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        prefs.remove('rollno');
        prefs.remove('name');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    addstudent();
    deletestudent();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Shared Preferences"),
        ),
        body: Form(
          child: Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter Name',
                      ),
                    ),
                    TextFormField(
                      controller: rollnocontroller,
                      decoration: InputDecoration(
                        labelText: 'Rollno',
                        hintText: 'Enter Rollno',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addstudent();
                        debugPrint('Added');
                      },
                      child: Icon(Icons.add),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        deletestudent();
                        debugPrint('Deleted');
                      },
                      child: Icon(Icons.remove),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Information'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(namecontroller.text),
                                    Text(rollnocontroller.text),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text('Show'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
