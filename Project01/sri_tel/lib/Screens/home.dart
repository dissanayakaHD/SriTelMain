import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sri_tel/app_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<AppState>(
        builder: (context, appState, _) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome !',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              appState.user!.email,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            IconButton(
              onPressed: () => appState.logout(),
              tooltip: 'Logout',
              icon: const Icon(Icons.logout),
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}
