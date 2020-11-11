import 'package:Tasks/models/task.model.dart';
import 'package:flutter/material.dart';


class ViewScreen extends StatefulWidget {
  final List<Task> mytask;

  const ViewScreen({Key key, this.mytask}) : super(key: key);

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  void removeAll() {
    setState(() {
      widget.mytask.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('View task'),
      ),
      body:
          widget.mytask.isEmpty 
              ? Center(
                  child: Text(
                    'No tasks added yet',
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                )
          :
          ListView.builder(
        itemCount: widget.mytask.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(left: 20.0, top: 30.0),
                child: Row(
                  children: <Widget>[
                    Text("Task :   " + widget.mytask[index].name),
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
                    Text("Time : " + widget.mytask[index].time),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: removeAll,
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
        tooltip: 'Delete all',
      ),
    );
  }
}
