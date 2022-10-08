import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext context)? editTapped;
  final Function(BuildContext context)? deleteTapped;
  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.editTapped,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // editing option
            SlidableAction(
              backgroundColor: Colors.grey.shade800,
              icon: Icons.edit,
              // borderRadius: BorderRadius.circular(12),
              onPressed: editTapped,
            ),
            // delete option
            SlidableAction(
              backgroundColor: Colors.red,
              icon: Icons.delete_forever,
              onPressed: deleteTapped,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:
                (habitCompleted) ? Colors.green.shade300 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Checkbox(
                activeColor: Colors.green,
                value: habitCompleted,
                onChanged: onChanged,
              ),
              Text(
                habitName,
                style: TextStyle(
                  color: habitCompleted ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_back,
                color: Colors.grey.shade400,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
