import 'package:flutter/material.dart';
import 'package:sri_tel/Screens/bill.dart';
import 'package:sri_tel/Screens/chat.dart';
import 'package:sri_tel/Screens/home.dart';
import 'package:sri_tel/Screens/issues.dart';
import 'package:sri_tel/Screens/vas.dart';

class Rail extends StatefulWidget {
  const Rail(this.index, {super.key});
  final int index;

  @override
  State<Rail> createState() => _RailState();
}

class _RailState extends State<Rail> {
  late int _selectedPage;

  @override
  void initState() {
    _selectedPage = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              // NavigationRailDestination(
              //   icon: Icon(Icons.sell_rounded),
              //   label: Text('Services'),
              // ),
              // NavigationRailDestination(
              //   icon: Icon(Icons.blinds_closed),
              //   label: Text('Bills'),
              // ),
              NavigationRailDestination(
                icon: Icon(Icons.contact_mail_sharp),
                label: Text('Issue'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.chat),
                label: Text('Chat'),
              ),
            ],
            selectedIndex: _selectedPage,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedPage = index;
              });
            },
          ),
          Expanded(
            child: _getPage(_selectedPage),
          ),
        ],
      ),
    );
  }
}

Widget _getPage(int index) {
  switch (index) {
    case 0:
      return Home();
    // case 1:
    //   return const VAS();
    // case 1:
    //   return const BillS();
    case 1:
      return const Issues();
    case 2:
      return const ChatS();
    default:
      return Container(); // Handle the case for an invalid index.
  }
}
