import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Monserrat',
          scaffoldBackgroundColor: Colors.white,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            for (var entry in TargetPlatform.values) entry: CustomPageTransitionsBuilder(),
          }),
        ),
        onGenerateRoute: routGenerator);
  }
}
