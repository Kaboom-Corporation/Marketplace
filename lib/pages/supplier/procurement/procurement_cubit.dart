import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marketplace/shared/data/procurement.dart';

class ProcurementCubit extends Cubit<ProcurementState> {
  ProcurementCubit(this.ref) : super(ProcurementStateLoading()) {
    get();
  }

  DocumentReference<Map<String, dynamic>> ref;

  void get() async {
    await ref.get().then((value) {
      if (value.exists) {
        Procurement procurement = Procurement.fromMap(value.data()!);
        emit(ProcurementStateLoaded(procurement: procurement, ref: ref));
      }
    });
  }
}

abstract class ProcurementState {}

class ProcurementStateLoading extends ProcurementState {}

class ProcurementStateLoaded extends ProcurementState {
  Procurement procurement;
  DocumentReference<Map<String, dynamic>> ref;
  ProcurementStateLoaded({
    required this.procurement,
    required this.ref,
  });
}
