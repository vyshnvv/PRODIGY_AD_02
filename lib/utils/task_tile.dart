import 'package:flutter/material.dart';
import 'package:notes_app/utils/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool taskStatus;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  Function(BuildContext)? editTask;
  TaskTile({
    super.key,
    required this.taskName,
    required this.taskStatus,
    required this.onChanged,
    required this.editTask,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: secondaryColor1,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
              image: AssetImage(
                "assets/noise.png",
              ),
              fit: BoxFit.cover)),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: editTask,
            icon: Icons.edit,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            backgroundColor: secondaryColor4,
            foregroundColor: secondaryColor1,
          ),
          SlidableAction(
            onPressed: deleteTask,
            icon: Icons.delete_forever,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            backgroundColor: secondaryColor3,
            foregroundColor: secondaryColor1,
          )
        ]),
        child: Row(
          children: [
            Checkbox(
              checkColor: secondaryColor1,
              activeColor: bgColor,
              value: taskStatus,
              onChanged: onChanged,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              side: WidgetStateBorderSide.resolveWith(
                (states) => BorderSide(width: 2, color: secondaryColor2),
              ),
            ),
            Text(
              taskName,
              style: TextStyle(
                  decorationColor: secondaryColor1,
                  decorationThickness: 3,
                  color: secondaryColor2,
                  fontWeight: FontWeight.bold,
                  decoration: taskStatus
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
              textScaler: TextScaler.linear(size.width * 0.003),
            ),
          ],
        ),
      ),
    );
  }
}
