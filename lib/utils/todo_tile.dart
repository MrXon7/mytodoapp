import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  ToDoTile(
      {super.key,
      required this.taskname,
      required this.taskComplated,
      required this.onChanged,
      required this.deleteFunc});

  final String taskname;
  final bool taskComplated;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunc,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Checkbox(
                side: BorderSide(color: Colors.white),
                value: taskComplated,
                onChanged: onChanged,
                activeColor: Colors.white,
                checkColor: Colors.deepPurple,
              ),
              // task name
              Text(
                taskname,
                style: TextStyle(
                    color: Colors.white,
                    decoration: taskComplated
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
