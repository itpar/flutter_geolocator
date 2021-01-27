import 'package:flutter/material.dart';
import 'package:flutter_geolocator/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'codesundar',
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(centerTitle: true, color: Colors.black, elevation: 0),
          scaffoldBackgroundColor: Colors.grey[200]),
      home: SafeArea(child: HomePage()),
    );
  }
}
