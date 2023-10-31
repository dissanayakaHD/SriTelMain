import 'package:flutter/material.dart';
import 'package:sri_tel/Screens/bill.dart';
import 'package:sri_tel/Screens/chat.dart';
import 'package:sri_tel/Screens/home.dart';
import 'package:sri_tel/Screens/issues.dart';
import 'package:sri_tel/Screens/vas.dart';

class Nav extends StatefulWidget {
  const Nav(this.index, {super.key});
  final int index;

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  late int _selectedPage;

  @override
  void initState() {
    _selectedPage = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add_call), label: 'Services'),
          NavigationDestination(icon: Icon(Icons.blinds_closed), label: 'Bills'),
          NavigationDestination(icon: Icon(Icons.contact_mail_sharp), label: 'Issue'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
        ],
        selectedIndex: _selectedPage,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
      ),
      body: [Home(), const VAS(), const BillS(), const Issues(), const ChatS()][_selectedPage],
    );
  }
}
