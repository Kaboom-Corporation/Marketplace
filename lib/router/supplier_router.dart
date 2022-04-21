import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/main.dart';
import 'package:marketplace/pages/supplier/offer/chat_cubit.dart';
import 'package:marketplace/pages/supplier/offer/chat_page.dart';
import 'package:marketplace/pages/supplier/procurement/offers_cubit.dart';
import 'package:marketplace/pages/supplier/procurement/procurement_cubit.dart';
import 'package:marketplace/pages/supplier/auth/auth_cubit.dart';
import 'package:marketplace/pages/supplier/auth/auth_page.dart';
import 'package:marketplace/pages/supplier/procurement/procurement_info_page.dart';
import 'package:marketplace/pages/supplier/procurement/procurement_offers_page.dart';
import 'package:marketplace/pages/supplier/procurements/procurements_cubit.dart';
import 'package:marketplace/pages/supplier/procurements/procurements_page.dart';
import 'package:marketplace/pages/supplier/profile/profile_page.dart';
import 'package:marketplace/pages/supplier/register/register_cubit.dart';
import 'package:marketplace/pages/supplier/register/register_page.dart';
import 'package:marketplace/router/router.dart';

const String supplierPath = '/supplier';

Route<dynamic>? supplierRoutGenerator(RouteSettings settings) {
  String nonSupplierPath = settings.name!.substring(supplierPath.length);

  print(settings.arguments.toString());

  if (FirebaseAuth.instance.currentUser == null || isSupplier == false) {
    switch (nonSupplierPath) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (c) => AuthCubit(), child: const AuthPage()), settings: settings);
      case '/auth':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (c) => AuthCubit(), child: const AuthPage()), settings: settings);
      case '/register':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (c) => RegisterCubit(), child: const RegisterPage()),
            settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (c) => AuthCubit(), child: const AuthPage()),
            settings: const RouteSettings(name: supplierPath + '/auth'));
    }
  } else {
    switch (nonSupplierPath) {
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage(), settings: settings);
      case '/procurements':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (c) => ProcurementsCubit(), child: const ProcurementsPage()),
            settings: settings);
      case '/procurement-info':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (c) => ProcurementCubit(settings.arguments as DocumentReference<Map<String, dynamic>>),
                child: const ProcurementInfoPage()),
            settings: settings);
      case '/procurement-offers':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(
                      create: (c) => OffersCubit(settings.arguments as DocumentReference<Map<String, dynamic>>)),
                  BlocProvider(
                      create: (c) => ProcurementCubit(settings.arguments as DocumentReference<Map<String, dynamic>>)),
                ], child: const ProcurementOffersPage()),
            settings: settings);
      case '/offer-chat':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (c) => ChatCubit(settings.arguments as DocumentReference<Map<String, dynamic>>)),
                    BlocProvider(
                        create: (c) => ProcurementCubit(
                            (settings.arguments as DocumentReference<Map<String, dynamic>>).parent.parent!)),
                  ],
                  child: const ChatPage(),
                ),
            settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(create: (c) => ProcurementsCubit(), child: const ProcurementsPage()),
            settings: const RouteSettings(name: supplierPath + '/procurements'));
    }
  }
}
