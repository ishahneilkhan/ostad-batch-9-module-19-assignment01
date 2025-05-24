import 'package:flutter/material.dart';
import 'package:tm_getx/ui/screens/progress_task_screen.dart';
import 'package:tm_getx/ui/widgets/tm_app_bar.dart';
import 'canelled_task_screen.dart';
import 'completed_task_screen.dart';
import 'new_task_screen.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});
  static const String name='/home';

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
    ProgressTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.new_label),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_box),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.close),
            label: 'Cancelled',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time_outlined),
            label: 'Progress',
          )
        ],
      ),
    );
  }
}
