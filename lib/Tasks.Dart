import 'package:flutter/material.dart';
import 'package:Tasks/View-tasks.Dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  TextEditingController etTaskname = new TextEditingController();
  TextEditingController etTasktime = new TextEditingController();

  Mytask task = Mytask("", "");
  List<Mytask> myarray = [];

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
              padding: const EdgeInsets.all(20.0),
            ),
            Text(
              'Create Your To Do List Here',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.red),
            ),
            TextFormField(
              controller: etTaskname,
              decoration: InputDecoration(hintText: 'Task Name'),
            ),
            TextFormField(
              controller: etTasktime,
              decoration: InputDecoration(hintText: 'Task Time'),
            ),
            SizedBox(
              width: 80.0,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: () {
                  myarray.add(Mytask(etTaskname.text, etTasktime.text));
                },
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Add'),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: () {
                  // Navigate to NextScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
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
            ),
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
