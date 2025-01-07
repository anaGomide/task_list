import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../viewmodels/task_view_model.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/create_task_modal.dart';
import '../widgets/custom_nav_bar_widget.dart';
import '../widgets/search_task_widget.dart';
import '../widgets/task_card.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

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

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    final filteredTasks = _searchQuery.isEmpty
        ? taskViewModel.tasks.where((task) => !task.isCompleted).toList()
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _isSearchActive
                    ? // Campo de Busca
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
                Expanded(
                  child: filteredTasks.isEmpty
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
                              if (_searchQuery.isEmpty) ...[
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    CreateTaskModal.show(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFE6F2FF),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  ),
                                  icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
                                  label: Text(
                                    'Create task',
                                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                  ),
                                ),
                              ],
                            ],
                          ),
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
        currentIndex: 0,
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
