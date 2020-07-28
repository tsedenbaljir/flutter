import 'package:flutter/material.dart';
import 'first_page.dart';
import 'second_page.dart';
import 'last_page.dart';

class BottomNavigationBarController extends StatefulWidget {
  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  final List<Widget> pages = [
    First_page(
      key: PageStorageKey('Page1'),
    ),
    SecondPage(
      key: PageStorageKey('Page2'),
    ),
    Last_page(
      key: PageStorageKey('Page3'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Нүүр')),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Жагсаалт')),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), title: Text('Товчлол')),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ломбард')),
      drawerEnableOpenDragGesture: false,
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
