import 'package:flutter/material.dart';

import 'screens/catalog_screen/catalog_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buffet App',
      home: MenuScreen(),
    );
  }
}


