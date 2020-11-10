import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Todo ',
    theme: ThemeData(primaryColor: Colors.red),
    home: Tasks(),
  ));
}

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  TextEditingController etTaskname = new TextEditingController();
  TextEditingController etTasktime = new TextEditingController();

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Todo Tasks'),
      ),
      body: Form(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
            ),
            Text(
              'Welcome to our system',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                  color: Colors.red),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              'Create Your To Do List Here',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: etTaskname,
                decoration: InputDecoration(
                  // contentPadding:  const EdgeInsets.only(left: 3.0),
                    hintText: 'Please Enter Task Name',
                    errorText:
                        taskNameError == "" ? "" : "Please enter task name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: etTasktime,
                decoration: InputDecoration(
                  hintText: 'Task Time',
                  errorText: taskTimeError == "" ? "" : "Please enter task time",
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
                            });
                        setState(() {
                          etTasktime.text = picked.format(context);
                        });
                      }),
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(width: 80.0),
                  MaterialButton(
                    onPressed: () {
                      bool isValid = validate();
                      if (isValid) {
                        etTaskname.clear();
                        etTasktime.clear();
                        alterMessage("Task Added Successful");
                      }
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Add'),
                  ),
                  SizedBox(width: 12.0),
                                    MaterialButton(
                    onPressed: () {},
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('View'),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
