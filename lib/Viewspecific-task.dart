import 'package:flutter/material.dart';

class ViewSpecificTask extends StatefulWidget {
  final String name;
  final String time;
  final String description;

  const ViewSpecificTask({Key key, this.name, this.time, this.description}) : super(key: key);
  @override
  _ViewSpecificTaskState createState() => _ViewSpecificTaskState();
}

class _ViewSpecificTaskState extends State<ViewSpecificTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("${widget.name}"),
      ),
      body: Column(children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(left: 20.0, top: 30.0),
                          child: Row(
                            children: <Widget>[
                              Text("Task :    ${widget.time}",
                              style: TextStyle(fontSize: 16.0,),
                              ),
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
                            Text("Desc :    ${widget.description}",
                          style: TextStyle(fontSize: 16.0,),),
                            ],
                          ),
                        ),

     ],
     )
      
            
    );
  }
}
