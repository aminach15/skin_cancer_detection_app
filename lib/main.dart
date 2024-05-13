import 'package:flutter/material.dart';
import 'package:my_skin_cancer_app/bottomnavbar.dart';
import 'package:my_skin_cancer_app/home.dart';
import 'package:my_skin_cancer_app/utils/themes/theme.dart';

import 'navigation_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: DAppTheme.lightTheme,
      darkTheme: DAppTheme.darkTheme,
    home: MyNavBar(),);
  }
}

