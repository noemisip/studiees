import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stud_iees/colors.dart';
import 'package:stud_iees/screens/info_screen.dart';
import 'package:stud_iees/screens/subjects_page.dart';

import 'add_subject.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _HomeScreen(),
    );
  }
}


class _HomeScreen extends StatefulWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<_HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Scaffold(
      body: SubjectPage(),
    ),
    Scaffold(
      body: AddPage(),
    ),
    Scaffold(
      body: AddPage(),
    ),
    Scaffold(
      body: InfoPage(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.background1,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:  const Icon(Icons.school),
            label: tr("subjects"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: tr("new_subject"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.book),
            label: tr("diary"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.info),
            label: tr("info"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyColors.selectedColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
