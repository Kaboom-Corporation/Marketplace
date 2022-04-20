import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/router/purchaser_router.dart';
import 'package:marketplace/router/router.dart';
import 'package:marketplace/router/supplier_router.dart';

bool isSupplier = false;
bool isPurchaser = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((event) {
    if (event == null) {
      isSupplier = false;
      isPurchaser = false;
    }
  });
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Торги",
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
