import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Viewing Data',
    theme: ThemeData(
      primaryColor: Colors.red,
    ),
  ));
}

class Myview extends StatefulWidget {
  @override
  _MyviewState createState() => _MyviewState();
}

class _MyviewState extends State<Myview> {
  TextEditingController etTaskname = new TextEditingController();
  TextEditingController etTasktime = new TextEditingController();

  Task task = Task("", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('View task'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
            ),
            Text(
              'Create Your To Do List Here',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.red),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: etTaskname,
              decoration: InputDecoration(hintText: 'Task Name'),
            ),
            SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: etTasktime,
              decoration: InputDecoration(
                hintText: 'Task Time',
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
            SizedBox(
              height: 20.0,
            ),
            Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        task.name = etTaskname.text;
                        task.time = etTasktime.text;
                        etTaskname.clear();
                        etTasktime.clear();
                      },
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Add'),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
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
                )),
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
  List<Task> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('View task'),
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
