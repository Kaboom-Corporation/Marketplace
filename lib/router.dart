// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/pages/auth/auth_page.dart';
import 'package:marketplace/pages/register/register_page.dart';

Route<dynamic>? routGenerator(RouteSettings settings) {
  // FirebaseAuth auth = FirebaseAuth.instance;

  // if (auth.currentUser == null) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const AuthPage(), settings: const RouteSettings(name: '/'));
    case '/auth':
      return MaterialPageRoute(builder: (_) => const AuthPage(), settings: const RouteSettings(name: '/auth'));
    case '/register':
      return MaterialPageRoute(builder: (_) => const RegisterPage(), settings: const RouteSettings(name: '/register'));
    default:
      return MaterialPageRoute(builder: (_) => const AuthPage(), settings: const RouteSettings(name: '/auth'));
    //   }
    // } else {
    //   switch (settings.name) {
    //     default:
    //       return MaterialPageRoute(builder: (_) => const AuthPage(), settings: const RouteSettings(name: '/'));
    //   }
  }
}
