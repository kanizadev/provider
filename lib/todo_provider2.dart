import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todo_list/todo_model2.dart';

class TodoProvider2 extends ChangeNotifier {
  final List<TodoModel2> _tasks2 = [];
  UnmodifiableListView<TodoModel2> get allTasks2 =>
      UnmodifiableListView(_tasks2);

  void addTask2(
    String task2, {
    String subtitle2 = '',
    DateTime? date2,
    TimeOfDay? time2,
  }) {
    _tasks2.add(
      TodoModel2(
        toDoTitle2: task2,
        subtitle2: subtitle2,
        date2: date2,
        time2: time2,
        completed2: false,
      ),
    );
    notifyListeners();
  }

  void toggleTask2(TodoModel2 task2) {
    final taskIndex2 = _tasks2.indexOf(task2);
    _tasks2[taskIndex2].toggleCompleted2();
    notifyListeners();
  }

  void deleteTask2(TodoModel2 task2) {
    _tasks2.remove(task2);
    notifyListeners();
  }
}
