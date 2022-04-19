import 'package:flutter/material.dart';
import 'package:marketplace/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Monserrat', scaffoldBackgroundColor: Colors.white),
        onGenerateRoute: routGenerator);
  }
}
