import 'package:flutter/material.dart';
import 'package:flutter_project_1/pages/detail/details_page.dart';
import 'package:flutter_project_1/pages/home/home_page.dart';
import 'package:flutter_project_1/route/pages.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // <== définit le thème Light
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        // <== définit le thème Dark
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      initialRoute: Pages.home,
      routes: {
        Pages.home: (context) => const HomePage(),
        Pages.detail: (context) => const DetailPage(),
      },
      // home: SnackBarPage(),
    );
  }
}
