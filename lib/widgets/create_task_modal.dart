import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/task_view_model.dart';

class CreateTaskModal {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return _CreateTaskModalContent();
      },
    );
  }
}

class _CreateTaskModalContent extends StatefulWidget {
  @override
  _CreateTaskModalContentState createState() => _CreateTaskModalContentState();
}

class _CreateTaskModalContentState extends State<_CreateTaskModalContent> {
  String taskTitle = '';
  String taskNote = '';
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  value: isCompleted,
                  onChanged: (value) {
                    setState(() {
                      isCompleted = value ?? false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: isCompleted
                      ? BorderSide.none
                      : const BorderSide(
                          color: Color(0xFFC6CFDC),
                          width: 1,
                        ),
                  fillColor: isCompleted ? WidgetStateProperty.all(const Color(0xFFC6CFDC)) : WidgetStateProperty.all(Colors.transparent),
                  checkColor: isCompleted ? Colors.white : null,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    taskTitle = value;
                  },
                  style: Theme.of(context).textTheme.titleLarge,
                  decoration: InputDecoration(
                    hintText: "What's in your mind?",
                    hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey,
                        ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.edit, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    taskNote = value;
                  },
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: InputDecoration(
                    hintText: "Add a note...",
                    hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                        ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                if (taskTitle.isNotEmpty) {
                  Provider.of<TaskViewModel>(context, listen: false).addTask(taskTitle, taskNote, isCompleted);
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Create',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
