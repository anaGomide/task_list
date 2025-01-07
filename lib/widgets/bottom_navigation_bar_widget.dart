import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarWidget extends StatefulWidget {
  final Function onCreateTapped;
  final Function(int) onSearchTapped;
  final int currentIndex;

  BottomNavBarWidget({
    super.key,
    required this.onCreateTapped,
    required this.onSearchTapped,
    this.currentIndex = 0,
  });

  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/todo');
        break;
      case 1:
        widget.onCreateTapped();
        break;
      case 2:
        widget.onSearchTapped(index);
        break;
      case 3:
        Navigator.pushNamed(context, '/done');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
