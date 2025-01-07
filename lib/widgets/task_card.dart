import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/task_view_model.dart';

class TaskCard extends StatefulWidget {
  final dynamic task;

  const TaskCard({super.key, required this.task});

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isDescriptionVisible = false;

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);

    final textStyle = widget.task.isCompleted
        ? Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey,
            )
        : Theme.of(context).textTheme.headlineSmall;

    final cardColor = Theme.of(context).colorScheme.surface;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: Checkbox(
                    value: widget.task.isCompleted,
                    onChanged: (value) {
                      taskViewModel.toggleTaskCompletion(widget.task);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: widget.task.isCompleted
                        ? BorderSide.none
                        : const BorderSide(
                            color: Color(0xFFC6CFDC),
                            width: 1,
                          ),
                    fillColor:
                        widget.task.isCompleted ? WidgetStateProperty.all(const Color(0xFFC6CFDC)) : WidgetStateProperty.all(Colors.transparent),
                    checkColor: widget.task.isCompleted ? Colors.white : null,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.task.title,
                          style: textStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      widget.task.isCompleted
                          ? IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                taskViewModel.deleteTask(widget.task.id);
                              },
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.more_horiz,
                                color: Color(0xFFC6CFDC),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isDescriptionVisible = !_isDescriptionVisible;
                                });
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
            if (_isDescriptionVisible)
              Padding(
                padding: const EdgeInsets.only(left: 44),
                child: Text(
                  widget.task.description ?? 'No description available.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
