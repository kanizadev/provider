import 'package:flutter/material.dart';

class TodoModel2 {
  String toDoTitle2;
  String subtitle2;
  DateTime? date2;
  TimeOfDay? time2;
  bool completed2;

  TodoModel2({
    required this.toDoTitle2,
    this.subtitle2 = '',
    this.date2,
    this.time2,
    this.completed2 = false,
  });

  void toggleCompleted2() {
    completed2 = !completed2;
  }
}
