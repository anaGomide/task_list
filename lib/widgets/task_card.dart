import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/task_view_model.dart';

class TaskCard extends StatefulWidget {
  final dynamic task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isDescriptionVisible = false;

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Linha principal com Checkbox, Título e Ícone
            Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Alinha no centro vertical
              children: [
                Transform.scale(
                  scale: 1.5, // Ajusta o tamanho do Checkbox
                  child: Checkbox(
                    value: widget.task.isCompleted,
                    onChanged: (value) {
                      taskViewModel.toggleTaskCompletion(widget.task);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(
                      color: Color(0xFFC6CFDC), // Cor da borda
                      width: 1, // Espessura da borda
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center, // Alinha no centro vertical
                    children: [
                      Expanded(
                        child: Text(
                          widget.task.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: const Color(0xFFC6CFDC),
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
            // Descrição alinhada abaixo do título
            if (_isDescriptionVisible)
              Padding(
                padding: const EdgeInsets.only(left: 44), // Alinha com o título (42px equivale ao Checkbox + espaçamento)
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
