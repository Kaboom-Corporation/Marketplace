import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/main.dart';
import 'package:marketplace/pages/supplier/register/register_state.dart';
import 'package:marketplace/router/router.dart';
import 'package:marketplace/router/supplier_router.dart';
import 'package:marketplace/show_alert.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState()) {}

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String curentVerificationId;

  createUserAndNavigate({
    required String email,
    required String password,
    required String surname,
    required String name,
    required String lastName,
    required String organisationName,
    required String itin,
  }) {
    firestore.collection('suppliers').doc(auth.currentUser!.uid).set({
      "surname": surname,
      "name": name,
      "lastName": lastName,
      "organisationName": organisationName,
      "itin": itin,
    });

    isPurchaser = true;

    navigatorKey.currentState!.pushNamed(supplierPath + '/procurements');
  }

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
        createUserAndNavigate(
            email: email,
            password: password,
            surname: surname,
            name: name,
            lastName: lastName,
            organisationName: organisationName,
            itin: itin);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code != "email-already-in-use") {
        showAlert(e.message!);
        return e.message!;
      } else {
        if (auth.currentUser != null && auth.currentUser!.email == e.email) {
          createUserAndNavigate(
              email: email,
              password: password,
              surname: surname,
              name: name,
              lastName: lastName,
              organisationName: organisationName,
              itin: itin);
        } else if (auth.currentUser != null && auth.currentUser!.email != e.email) {
          trySignOutAndSignIn(
              email: email,
              password: password,
              surname: surname,
              name: name,
              lastName: lastName,
              organisationName: organisationName,
              itin: itin);
        } else {
          trySignIn(
              email: email,
              password: password,
              surname: surname,
              name: name,
              lastName: lastName,
              organisationName: organisationName,
              itin: itin);
        }
      }
    }
  }

  trySignOutAndSignIn(
      {required String email,
      required String password,
      required String surname,
      required String name,
      required String lastName,
      required String organisationName,
      required String itin}) async {
    try {
      await auth.signOut();
      trySignIn(
          email: email,
          password: password,
          surname: surname,
          name: name,
          lastName: lastName,
          organisationName: organisationName,
          itin: itin);
    } on FirebaseAuthException catch (e) {}
  }

  trySignIn(
      {required String email,
      required String password,
      required String surname,
      required String name,
      required String lastName,
      required String organisationName,
      required String itin}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      if (auth.currentUser != null) {
        if (isSupplier == false) {
          FirebaseFirestore.instance.collection('suppliers').doc(auth.currentUser!.uid).get().then((value) {
            if (value.exists) {
              isSupplier = true;
              navigatorKey.currentState!.pushNamed(supplierPath);
            } else if (!value.exists) {
              createUserAndNavigate(
                  email: email,
                  password: password,
                  surname: surname,
                  name: name,
                  lastName: lastName,
                  organisationName: organisationName,
                  itin: itin);
            }
          });
        } else {
          navigatorKey.currentState!.pushNamed(supplierPath + '/procurements');
        }
      }
    } on FirebaseAuthException catch (e) {
      showAlert(e.message!);
    }
  }
}
