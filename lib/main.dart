import 'package:flutter/material.dart';
import 'package:qubit_sb/shared/ui/home/home.dart';
import 'package:qubit_sb/shared/ui/theme/theme.dart';
import 'package:qubit_sb/shared/ui/theme/util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(
      context,
      "Roboto",
      "Roboto Condensed",
    );

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Qubit SB',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const Home(),
    );
  }
}
