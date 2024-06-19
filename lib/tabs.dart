import 'package:flutter/material.dart';
import 'package:goodbye_money/pages/add.dart';
import 'package:goodbye_money/pages/expenses.dart';
import 'package:goodbye_money/pages/reports.dart';
import 'package:goodbye_money/pages/settings.dart';
import 'package:goodbye_money/types/widget.dart';

class TabsController extends StatefulWidget {
  const TabsController({super.key});

  @override
  State<TabsController> createState() => _TabsControllerState();
}

class _TabsControllerState extends State<TabsController> {

  var _selectedIndex = 0;

  static const List<WidgetWithTitle> _pages = [
    Expenses(),
    Reports(),
    Add(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text(_pages[_selectedIndex].title),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.black,
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.paid),
                  label: 'Exxpenses',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Reposrts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Add',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settigns',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              fixedColor: Colors.blue,
              // selectedItemColor: Colors.white,
              // unselectedItemColor: Colors.grey,
            ),
          ));
  }
}