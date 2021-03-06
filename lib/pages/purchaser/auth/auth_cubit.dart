import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/main.dart';
import 'package:marketplace/pages/purchaser/auth/auth_states.dart';
import 'package:marketplace/router/purchaser_router.dart';
import 'package:marketplace/router/router.dart';
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
        if (isPurchaser == true) {
          navigatorKey.currentState!.pushNamed(purchaserPath + '/procurements');
        } else {
          FirebaseFirestore.instance.collection('purchasers').doc(auth.currentUser!.uid).get().then((value) {
            if (value.exists) {
              isPurchaser = true;
              navigatorKey.currentState!.pushNamed(purchaserPath);
            }
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      showAlert(e.message!);
      return e.message!;
    }
  }
}
