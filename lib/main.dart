import 'package:flutter/material.dart';
import 'Tasks.dart';

void main() {
  runApp(MaterialApp(
    title: 'Todos ',
    theme: ThemeData(primaryColor: Colors.red),
    home: Tasks(),
  ));
}
