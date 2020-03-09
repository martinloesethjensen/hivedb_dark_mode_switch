import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const darkModeBox = "darkMode";

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(darkModeBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = Hive.box(darkModeBox);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(darkModeBox).listenable(),
      builder: (BuildContext context, value, Widget child) {
        bool darkMode = box.get("darkMode", defaultValue: false);
        return MaterialApp(
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          home: Scaffold(
            appBar: AppBar(
              brightness: darkMode ? Brightness.dark : Brightness.light,
            ),
            body: Center(
              child: Switch(
                value: darkMode,
                onChanged: (_) {
                  box.put("darkMode", !darkMode);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
