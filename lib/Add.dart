import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Todos ',
    theme: ThemeData(primaryColor: Colors.red),
    home: Page1(),
  ));
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
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

  Task task = Task("", "");

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
            TextFormField(
              controller: etTaskname,
              decoration: InputDecoration(
                  hintText: 'Please Enter Task Name',
                  errorText:
                      taskNameError == "" ? "" : "Please enter task name"),
            ),
            TextFormField(
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
            Container(
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      bool isValid = validate();
                      if (isValid) {
                        task.name = etTaskname.text;
                        task.time = etTasktime.text;
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
                    onPressed: () {
                      // Navigate to NextScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ViewScreen(
                            task: task,
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
            )
          ],
        ),
      ),
    );
  }
}

class ViewScreen extends StatefulWidget {
  final Task task;
  const ViewScreen({Key key, this.task}) : super(key: key);
  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Todo Tasks'),
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
            ),
            Text(
              'My To Do List',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.red),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(left: 20.0, top: 30.0),
              child: Row(
                children: <Widget>[
                  Text("Task :   " + widget.task.name),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                left: 20.0,
                top: 10.0,
              ),
              child: Row(
                children: <Widget>[
                  Text("Time : " + widget.task.time),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String name;
  String time;

  Task(this.name, this.time);
}

