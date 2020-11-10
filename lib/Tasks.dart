import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Tasks/View-tasks.Dart';

void main() {
  runApp(MaterialApp(
    title: 'Todo',
    theme: ThemeData(primaryColor: Colors.red),
    home: Tasks(),
  ));
}

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  int selectedIndex;
  String title;
  String text = "No Value Entered";
  String title2;
  String text2 = "No Value Entered";
  TextEditingController etTaskname = new TextEditingController();
  TextEditingController etTasktime = new TextEditingController();

  Mytask task = Mytask("", "");
  List<Mytask> myarray = [];

  var taskNameError = '';
  var taskTimeError = '';

  bool validate() {
    if (etTaskname.text == "" && etTasktime.text == "") {
      this.setState(() {
        taskNameError = "Please provide task name";
        taskTimeError = "Please provide task time";
      });
      return false;
    } else if (etTaskname.text == "") {
      this.setState(() {
        taskNameError = "Please provide task name";
        taskTimeError = "";
      });
    } else if (etTasktime.text == "") {
      this.setState(() {
        taskNameError = "";
        taskTimeError = "Please provide task time";
      });
      return false;
    } else {
      this.setState(() {
        taskNameError = "";
        taskTimeError = "";
      });
      return true;
    }
  }

  Future<void> alterMessage(String success) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("$success",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12))
              ],
            ),
          );
        });
  }

  void _setText() {
    setState(() {
      if (selectedIndex == null) {
        bool isValid = validate();
        if (!isValid) {
          return null;
        }
        myarray.add(Mytask(
          etTaskname.text,
          etTasktime.text,
        ));
        alterMessage("Task Added Successful");
      } else {
        myarray.elementAt(selectedIndex).name = etTaskname.text;
        myarray.elementAt(selectedIndex).time = etTasktime.text;

        selectedIndex = null;
      }
      etTaskname.clear();
      etTasktime.clear();
    });
  }

  // List to hold all tasks

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do Tasks'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Welcome To Our System',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.red),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Create Your Task here',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Task',
                    border: OutlineInputBorder(),
                  ),
                  controller: etTaskname),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () async {
                      TimeOfDay picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (BuildContext context, Widget child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: true),
                            child: child,
                          );
                        },
                      );
                      setState(() {
                        etTasktime.text = picked.format(context);
                      });
                    },
                  ),
                ),
                controller: etTasktime,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 80,
                ),
                RaisedButton(
                  onPressed: _setText,
                  child: Text(selectedIndex == null ? 'Add' : 'Save'),
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 8,
                ),
                SizedBox(
                  width: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (BuildContext context) => ViewScreen(
                          mytask: myarray,
                        ),
                      ),
                    );
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('View'),
                ),
              ],
            ),

            // List to display tasks
            SizedBox(
<<<<<<< HEAD
              height: 200,
              child: ListView.builder(
                itemCount: myarray.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(myarray.elementAt(index).name),
                    subtitle: Text(myarray.elementAt(index).time),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        etTaskname.text = myarray.elementAt(index).name;
                        etTasktime.text = myarray.elementAt(index).time;
                      },
                      icon: Icon(Icons.edit),
                    ),
                  );
                },
              ),
            ),
=======
                height: 200,
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      title: Text(tasks.elementAt(index).title),
                      subtitle: Text(tasks.elementAt(index).time),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          smsCodeController.text = tasks.elementAt(index).title;
                          smsCodeController2.text = tasks.elementAt(index).time;
                        },
                        icon: Icon(Icons.edit),
                      ),
                    );
                  },
                )),
            // changes in text
            // are shown here
>>>>>>> ac5e6d0 (updating)
          ],
        ),
      ),
    );
  }
}

class Mytask {
  String name;
  String time;

  Mytask(this.name, this.time);
}
