import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.taskName,
    required this.taskcompleted,
    required this.onChanged,
    required this.deleteFunction,
    this.onTap,
  });

  final String taskName;
  final bool taskcompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
              )
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple[500],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: taskcompleted,
                  onChanged: onChanged,
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                ),
                Text(
                  taskName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: taskcompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 2,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
