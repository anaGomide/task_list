import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarWidget extends StatefulWidget {
  final Function onCreateTapped;
  final Function(int) onSearchTapped;

  BottomNavBarWidget({
    required this.onCreateTapped,
    required this.onSearchTapped,
  });

  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          // Ação para a aba "Todo"
          Navigator.pushNamed(context, '/todo');
          break;
        case 1:
          // Ação para a aba "Create"
          widget.onCreateTapped();
          break;
        case 2:
          // Ação para a aba "Search"
          widget.onSearchTapped(index);
          break;
        case 3:
          // Ação para a aba "Done"
          Navigator.pushNamed(context, '/done');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFF5F7F9),
            width: 1.0,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/todo.svg',
              color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
              height: 24,
            ),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/create.svg',
              color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
              height: 24,
            ),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/search.svg',
              color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
              height: 24,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/checked.svg',
              color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
              height: 24,
            ),
            label: 'Done',
          ),
        ],
      ),
    );
  }
}
