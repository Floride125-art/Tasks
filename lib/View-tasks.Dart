import 'package:flutter/material.dart';
import 'package:Tasks/Tasks.dart';

class ViewScreen extends StatefulWidget {
  final List<Mytask> mytask;

  const ViewScreen({Key key, this.mytask}) : super(key: key);

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  bool isEmpty = true;
  @override
  void initState() {
    if (widget.mytask.length == 0) {
      this.setState(() {
        isEmpty = true;
      });
    } else {
      this.setState(() {
        isEmpty = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('View task'),
        ),
        body: isEmpty == true
            ? Center(
                child: Text(
                  'No tasks added yet',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                  // textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: widget.mytask.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
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
              ));
  }
}
