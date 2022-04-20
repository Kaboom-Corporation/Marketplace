import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/main.dart';
import 'package:marketplace/pages/auth/auth_states.dart';
import 'package:marketplace/show_alert.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState()) {}

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String curentVerificationId;

  logIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      if (auth.currentUser != null) {
        navigatorKey.currentState!.pushNamed('/procurements');
      }
    } on FirebaseAuthException catch (e) {
      showAlert(e.message!);
      return e.message!;
    }
  }
}
