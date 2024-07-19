import 'package:flutter/material.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:notes_app/utils/customButton.dart';

class ShowDialogBox extends StatelessWidget {
  final taskController;
  VoidCallback onSave;
  VoidCallback onCancel;
  bool edit;
  ShowDialogBox(
      {super.key,
      required this.taskController,
      required this.onSave,
      required this.onCancel,
      required this.edit});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: secondaryColor1,
      content: Container(
        height: size.height * 0.15,
        width: size.width * 0.9,
        child: Column(
          children: [
            TextField(
              controller: taskController,
              style: TextStyle(
                  color: secondaryColor2, fontWeight: FontWeight.bold),
              cursorColor: secondaryColor2,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.note_add_outlined),
                  prefixIconColor: secondaryColor2,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: bgColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: bgColor)),
                  labelText: edit == true ? "Edit task" : "Add new task",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: secondaryColor2)),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: onSave,
                  btnText: "Save",
                ),
                CustomButton(
                  onPressed: onCancel,
                  btnText: "Cancel",
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
