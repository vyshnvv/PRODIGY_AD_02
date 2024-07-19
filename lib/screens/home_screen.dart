import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/data/db.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:notes_app/utils/showdialogbox.dart';
import 'package:notes_app/utils/task_tile.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home-page';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final addtaskController = TextEditingController();
  final edittaskController = TextEditingController();
  final hivebox = Hive.box("hivebox");
  ToDoDB db = ToDoDB();

  @override
  void initState() {
    if (hivebox.get("ToDoList") == null) {
      db.inititalData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void taskStatusChanged(bool? val, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  void onSave() {
    db.toDoList.add([addtaskController.text, false]);
    Navigator.of(context).pop();
    db.updateData();
  }

  void saveEdit(int index) {
    setState(() {
      db.toDoList[index][0] = edittaskController.text;
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void addTask() {
    addtaskController.clear();
    showDialog(
        context: context,
        builder: (context) {
          return ShowDialogBox(
            taskController: addtaskController,
            onSave: onSave,
            onCancel: () => Navigator.of(context).pop(),
            edit: false,
          );
        });
    db.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  void editTask(int index) {
    edittaskController.clear();
    showDialog(
        context: context,
        builder: (context) {
          return ShowDialogBox(
            edit: true,
            taskController: edittaskController,
            onSave: () {
              saveEdit(index);
            },
            onCancel: () => Navigator.of(context).pop(),
          );
        });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        toolbarHeight: size.height * 0.07,
        title: Text(
          "Tasks",
          textScaler: TextScaler.linear(
            size.width * 0.004,
          ),
          style: TextStyle(color: secondaryColor1, fontFamily: "Marmelat"),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        backgroundColor: secondaryColor1,
        foregroundColor: secondaryColor2,
        shape: CircleBorder(),
        child: Icon(
          size: size.width * 0.08,
          Icons.add,
          color: secondaryColor2,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: db.toDoList.isEmpty
            ? Container(
                alignment: Alignment.center,
                child: Text(
                  "No pending tasks :)",
                  style: TextStyle(
                      color: secondaryColor1,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.05),
                ))
            : ListView.builder(
                itemCount: db.toDoList.length,
                itemBuilder: (context, index) {
                  return TaskTile(
                    taskName: db.toDoList[index][0],
                    taskStatus: db.toDoList[index][1],
                    onChanged: (value) => taskStatusChanged(value, index),
                    deleteTask: (context) => deleteTask(index),
                    editTask: (context) => editTask(index),
                  );
                },
              ),
      ),
    ));
  }
}
