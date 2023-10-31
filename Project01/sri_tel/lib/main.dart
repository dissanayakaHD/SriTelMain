import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sri_tel/app_state.dart';
import 'package:sri_tel/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppState()),
    ],
    builder: ((context, child) => const App()),
  ));
}
