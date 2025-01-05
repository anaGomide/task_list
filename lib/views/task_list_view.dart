import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../viewmodels/task_view_model.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/custom_nav_bar_widget.dart';
import '../widgets/task_card.dart';

class TaskListView extends StatefulWidget {
  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  late Future<void> _loadTasksFuture;
  bool _isSearchActive = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadTasksFuture = Provider.of<TaskViewModel>(context, listen: false).fetchTasks();
  }

  void _showCreateTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        String taskTitle = '';
        String taskDescription = '';

        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Task',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  taskTitle = value;
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  taskDescription = value;
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (taskTitle.isNotEmpty) {
                    Provider.of<TaskViewModel>(context, listen: false).addTask(taskTitle, taskDescription);
                    Navigator.pop(context); // Fecha a modal
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Create Task'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    // Filtra as tarefas com base na consulta de pesquisa
    final filteredTasks = _searchQuery.isEmpty
        ? taskViewModel.tasks
        : taskViewModel.tasks.where((task) {
            return task.title.toLowerCase().contains(_searchQuery.toLowerCase());
          }).toList();

    return Scaffold(
      appBar: CustomNavbar(
        username: 'John',
        profileImage: 'assets/avatar.png',
      ),
      body: FutureBuilder(
        future: _loadTasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar tarefas: ${snapshot.error}'),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _isSearchActive
                    ? // Campo de Busca
                    TextField(
                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search tasks',
                          prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear, color: Theme.of(context).colorScheme.primary),
                            onPressed: () {
                              setState(() {
                                _searchQuery = '';
                                _isSearchActive = false;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                          ),
                        ),
                      )
                    : // Welcome Header
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Welcome,',
                                style: Theme.of(context).textTheme.headlineLarge,
                              ),
                              Text(
                                ' John.',
                                style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "You've got ${taskViewModel.tasks.length} tasks to do.",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                const SizedBox(height: 16),
                // Lista de Tarefas ou Mensagem de "Nenhum Resultado"
                Expanded(
                  child: filteredTasks.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/no_result.svg',
                              width: 120,
                              height: 120,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No result found.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) {
                            final task = filteredTasks[index];
                            return TaskCard(task: task);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBarWidget(
        onSearchTapped: (index) {
          setState(() {
            _isSearchActive = true; // Ativa o modo de busca
          });
        },
        onCreateTapped: () {
          _showCreateTaskModal(context);
        },
      ),
    );
  }
}
