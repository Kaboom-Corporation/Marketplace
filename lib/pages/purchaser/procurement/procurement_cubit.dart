import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marketplace/shared/data/procurement.dart';

class ProcurementCubit extends Cubit<ProcurementState> {
  ProcurementCubit(this.id) : super(ProcurementStateLoading()) {
    get();
  }

  String id;

  void get() async {
    await FirebaseFirestore.instance
        .collection('purchasers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('procurements')
        .doc(id)
        .get()
        .then((value) {
      if (value.exists) {
        Procurement procurement = Procurement.fromMap(value.data()!);
        emit(ProcurementStateLoaded(procurement: procurement, id: id));
      }
    });
  }
}

abstract class ProcurementState {}

class ProcurementStateLoading extends ProcurementState {}

class ProcurementStateLoaded extends ProcurementState {
  Procurement procurement;
  String id;
  ProcurementStateLoaded({
    required this.procurement,
    required this.id,
  });
}
