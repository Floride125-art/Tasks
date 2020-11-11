import 'package:Tasks/models/task.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Viewspecific-task.dart';

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
      body: widget.mytask.isEmpty
          ? Center(
              child: Text(
                'No tasks added yet',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            )
          : ListView.builder(
              itemCount: widget.mytask.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                 child: Column(
                
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
                ),
                 onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (BuildContext context) => ViewSpecificTask(
                            name: widget.mytask[index].name,
                            time: widget.mytask[index].time,
                            description: widget.mytask[index].description,
                          ),
                        ),
                      );
                    },
                  
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







