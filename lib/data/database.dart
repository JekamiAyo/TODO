import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  //list of todos
  List toDoList = [];

  //reference our box
  var box = Hive.box("todoBox");

  //run method if first time ever opening app
  void createInitialData() {
    toDoList = [
      ["Workout", false],
      ["Go Shopping", false],
    ];
  }

  //load database
  void loadDatabase() {
    toDoList = box.get("TODOLIST");
  }

  //update the database
  void updateDatabase() {
    box.put("TODOLIST", toDoList);
  }
}
