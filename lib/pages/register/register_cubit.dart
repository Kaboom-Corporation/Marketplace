import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/main.dart';
import 'package:marketplace/pages/register/register_state.dart';
import 'package:marketplace/show_alert.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState()) {}

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String curentVerificationId;

  register({
    required String email,
    required String password,
    required String surname,
    required String name,
    required String lastName,
    required String organisationName,
    required String itin,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);

      if (auth.currentUser != null) {
        firestore.collection('users').doc(auth.currentUser!.uid).set({
          "surname": surname,
          "name": name,
          "lastName": lastName,
          "organisationName": organisationName,
          "itin": itin,
        });

        navigatorKey.currentState!.pushNamed('/procurements');
      }
    } on FirebaseAuthException catch (e) {
      showAlert(e.message!);
      return e.message!;
    }
  }
}
