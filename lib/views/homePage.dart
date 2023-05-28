import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import '../widgets/customAlertDialog.dart';
import '../widgets/toDoTile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //reference the box
  final box = Hive.box("todoBox");

  //import from database class
  ToDoDatabase db = ToDoDatabase();

  final taskTextController = TextEditingController();

  @override
  void initState() {
    //first time opening app
    if (box.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //there's already data
      db.loadDatabase();
    }

    super.initState();
  }

  //change value of individual checkboxes
  void checkBoxToggle(int index, bool? value) {
    setState(() {
      db.toDoList[index][1] = value;
    });
    db.updateDatabase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add(
        [taskTextController.text, false],
      );
    });
    taskTextController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

//create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          controller: taskTextController,
          onSave: saveNewTask,
          onCancel: Navigator.of(context).pop,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "TO DO",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              isCompleted: db.toDoList[index][1],
              onToggle: (val) => checkBoxToggle(index, val),
              onDelete: (val) => deleteTask(index),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: createNewTask,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
