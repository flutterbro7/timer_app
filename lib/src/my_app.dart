import 'package:flutter/material.dart';

import 'screens/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Timer App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:  Color(0xFF071952)),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
