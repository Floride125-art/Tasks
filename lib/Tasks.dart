import 'package:Tasks/models/task.model.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:Tasks/View-tasks.Dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  int selectedIndex;
  String title;
  bool isDelete = false;
  String text = "No Value Entered";
  String title2;
  String text2 = "No Value Entered";
  TextEditingController etTaskname = new TextEditingController();
  TextEditingController etTasktime = new TextEditingController();
  TextEditingController etdescription = new TextEditingController();

  Task task = Task("", "", "");
  List<Task> myarray = [];

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
        myarray.add(Task(
          etTaskname.text,
          etTasktime.text,
          etdescription.text,
        ));
        alterMessage("Task Added Successful");
      } else {
        myarray.elementAt(selectedIndex).name = etTaskname.text;
        myarray.elementAt(selectedIndex).time = etTasktime.text;
        myarray.elementAt(selectedIndex).description= etdescription.text;



        selectedIndex = null;
      }
      etTaskname.clear();
      etTasktime.clear();
      etdescription.clear();
    });
  }

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
                    hintText: 'Please Enter Task Name',
                    errorText:
                        taskNameError == "" ? "" : "Please enter task name",
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
                  hintText: 'Task Time',
                  errorText:
                      taskTimeError == "" ? "" : "Please enter task time",
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Details',
                    border: OutlineInputBorder(),
                  ),
                  controller: etdescription),
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
                  child: Text(selectedIndex == null || isDelete == true
                      ? 'Add'
                      : 'Save'),
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
                    Container(
                      child: Row(children: [
                        SizedBox(width: 80.0),
                        MaterialButton(
                          onPressed: () {
                            bool isValid = validate();
                            if (!isValid) {
                              return null;
                            }
                            myarray.add(Task(etTaskname.text, etTasktime.text,
                                etdescription.text));
                            etTaskname.clear();
                            etTasktime.clear();
                            
                            alterMessage("Task Added Successful");
                            task.name = etTaskname.text;
                            task.time = etTasktime.text;
                            
                          },
                          color: Colors.red,
                          textColor: Colors.white,
                          child: Text('Add'),
                        ),
                        SizedBox(width: 12.0),
                        MaterialButton(onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (BuildContext context) => ViewScreen(
                                mytask: myarray,
                              ),
                            ),
                          );
                        }),
                      ]),
                    );
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('View'),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: myarray.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Text(myarray.elementAt(index).name),
                              Text(myarray.elementAt(index).time),
                             
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                  etTaskname.text =
                                      myarray.elementAt(index).name;
                                  etTasktime.text =
                                      myarray.elementAt(index).time;
                          
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  this.setState(() {
                                    isDelete = true;
                                    myarray.removeAt(selectedIndex = index);
                                    selectedIndex = null;
                                  });
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
