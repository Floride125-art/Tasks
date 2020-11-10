import "package:flutter/material.dart";

void main() => runApp(Tasks());

class Tasks extends StatelessWidget {
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
  String titleTask;
  String text = "No Value Entered";
  String titleTaskb;
  var myTitle = TextEditingController();
  var myTime = TextEditingController();
  String textTaskb = "No Value Entered";
  void _setText() {
    setState(() {
      if (selectedIndex == null) {
        deletetasks.add(deleteTask(
          myTitle.text,
          myTime.text,
        ));
      } else {
        deletetasks.elementAt(selectedIndex).title = myTitle.text;
        deletetasks.elementAt(selectedIndex).time = myTime.text;
        selectedIndex = null;
      }
      myTitle.clear();
      myTime.clear();
    });
  }

  // List to hold all tasks
  List<deleteTask> deletetasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Tasks'),
        centerTitle: true,
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
                  controller: myTitle),
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
                        myTime.text = picked.format(context);
                      });
                    },
                  ),
                ),
                controller: myTime,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              onPressed: _setText,
              child: Text(selectedIndex == null ? 'Submit' : 'Submit'),
              elevation: 8,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: deletetasks.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(deletetasks.elementAt(index).title),
                    subtitle: Text(deletetasks.elementAt(index).time),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          deletetasks.removeAt(selectedIndex = index);
                        });
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
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

// ignore: camel_case_types
class deleteTask {
  String title;
  String time;
  deleteTask(this.title, this.time);
}
