import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/pages/auth/auth_cubit.dart';
import 'package:marketplace/pages/auth/auth_page.dart';
import 'package:marketplace/pages/procurement_add/procurement_add_page.dart';
import 'package:marketplace/pages/procurements/procurements_cubit.dart';
import 'package:marketplace/pages/procurements/procurements_page.dart';
import 'package:marketplace/pages/profile/profile_page.dart';
import 'package:marketplace/pages/register/register_cubit.dart';
import 'package:marketplace/pages/register/register_page.dart';

Route<dynamic>? routGenerator(RouteSettings settings) {
  FirebaseAuth auth = FirebaseAuth.instance;
  if (auth.currentUser == null) {
    switch (settings.name) {
      case '/':
        // return MaterialPageRoute(
        //     builder: (_) => const ProcuremenstPage(), settings: const RouteSettings(name: '/procurements'));
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (c) => AuthCubit(), child: const AuthPage()),
            settings: const RouteSettings(name: '/auth'));
      case '/auth':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (c) => AuthCubit(), child: const AuthPage()),
            settings: const RouteSettings(name: '/auth'));
      case '/register':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (c) => RegisterCubit(), child: const RegisterPage()),
            settings: const RouteSettings(name: '/register'));
      default:
        //  return MaterialPageRoute(
        //       builder: (_) => const ProcuremenstPage(), settings: const RouteSettings(name: '/procurements'));
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (c) => AuthCubit(), child: const AuthPage()),
            settings: const RouteSettings(name: '/auth'));
    }
  } else {
    switch (settings.name) {
      case '/procurements':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (c) => ProcurementsCubit(), child: const ProcurementsPage()),
            settings: const RouteSettings(name: '/procurements'));
      case '/add_procurement':
        return MaterialPageRoute(
            builder: (_) => const ProcurementAddPage(), settings: const RouteSettings(name: '/add_procurement'));
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage(), settings: const RouteSettings(name: '/profile'));
      default:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (c) => ProcurementsCubit(), child: const ProcurementsPage()),
            settings: const RouteSettings(name: '/procurements'));
    }
  }
}

class CustomPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutExpo,
      ),
      child: child,
    );
  }
}
