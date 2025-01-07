import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../viewmodels/task_view_model.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/create_task_modal.dart';
import '../widgets/custom_nav_bar_widget.dart';
import '../widgets/search_task_widget.dart';
import '../widgets/task_card.dart';

class TasksDoneView extends StatefulWidget {
  const TasksDoneView({super.key});

  @override
  _TasksDoneViewState createState() => _TasksDoneViewState();
}

class _TasksDoneViewState extends State<TasksDoneView> {
  late Future<void> _loadTasksFuture;
  bool _isSearchActive = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadTasksFuture = Provider.of<TaskViewModel>(context, listen: false).fetchTasks();
  }

  void _deleteAllCompletedTasks(TaskViewModel taskViewModel) async {
    final completedTasks = taskViewModel.tasks.where((task) => task.isCompleted).toList();
    for (var task in completedTasks) {
      await taskViewModel.deleteTask(task.id);
    }
    taskViewModel.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    final filteredCompletedTasks = _searchQuery.isEmpty
        ? taskViewModel.tasks.where((task) => task.isCompleted).toList()
        : taskViewModel.tasks.where((task) => task.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    return Scaffold(
      appBar: const CustomNavbar(
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isSearchActive)
                  SearchFieldWidget(
                    hintText: 'Search tasks',
                    searchQuery: _searchQuery,
                    onSearchChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    onClear: () {
                      setState(() {
                        _searchQuery = '';
                        _isSearchActive = false;
                      });
                    },
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Completed Tasks',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      GestureDetector(
                        onTap: () => _deleteAllCompletedTasks(taskViewModel),
                        child: Text(
                          'Delete All',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                Expanded(
                  child: filteredCompletedTasks.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/no_result.svg',
                                width: 120,
                                height: 120,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _searchQuery.isNotEmpty ? 'No result found.' : 'You have no task listed.',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredCompletedTasks.length,
                          itemBuilder: (context, index) {
                            final task = filteredCompletedTasks[index];
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
        currentIndex: 3,
        onSearchTapped: (index) {
          setState(() {
            _isSearchActive = true;
          });
        },
        onCreateTapped: () {
          CreateTaskModal.show(context);
        },
      ),
    );
  }
}
