import "package:flutter/material.dart";

void main() => runApp(Myupdate());

class Myupdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.white,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// var to store
// onChanged callback
  int selectedIndex;
  String title;
  String text = "No Value Entered";
  String time;
  var smsCodeController = TextEditingController();
  var smsCodeController2 = TextEditingController();
  String text2 = "No Value Entered";
  void _setText() {
    setState(() {
      if (selectedIndex == null) {
        tasks.add(Task(
          smsCodeController.text,
          smsCodeController2.text,
        ));
      } else {
        tasks.elementAt(selectedIndex).title = smsCodeController.text;
        tasks.elementAt(selectedIndex).time = smsCodeController2.text;
        selectedIndex = null;
      }
      smsCodeController.clear();
      smsCodeController2.clear();
    });
  }

  // List to hold all tasks
  List<Task> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Tasks'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Task',
                    border: OutlineInputBorder(),
                  ),
                  controller: smsCodeController),
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
                        smsCodeController2.text = picked.format(context);
                      });
                    },
                  ),
                ),
                controller: smsCodeController2,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              onPressed: _setText,
              child: Text(selectedIndex == null ? 'Submit' : 'Save'),
              elevation: 8,
            ),
            SizedBox(
              height: 20,
            ),
            // List to display tasks
            SizedBox(
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
              ),
            ),
            // changes in text
            // are shown here
          ],
        ),
      ),
    );
  }
}

class Task {
  String title;
  String time;
  Task(this.title, this.time);
}
