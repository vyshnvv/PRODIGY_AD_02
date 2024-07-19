import 'package:hive/hive.dart';

class ToDoDB {
  final hiveBox = Hive.box("hivebox");
  List toDoList = [[]];

  void inititalData() {
    toDoList = [
      ["Sample Task", false]
    ];
  }

  void loadData() {
    toDoList = hiveBox.get("ToDoList");
  }

  void updateData() {
    hiveBox.put("ToDoList", toDoList);
  }
}
