import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/pages/purchaser/procurements/procurements_states.dart';
import 'package:marketplace/shared/data/procurement.dart';

class ProcurementsCubit extends Cubit<ProcurementsState> {
  ProcurementsCubit() : super(ProcurementsStateLoading()) {
    getAll();
  }

  void getAll() async {
    List<String> ids = [];
    List<Procurement> procurements = await FirebaseFirestore.instance
        .collection('purchasers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('procurements')
        .get()
        .then((value) => value.docs.map((e) {
              ids.add(e.id);
              return Procurement.fromMap(e.data());
            }).toList());

    emit(ProcurementsStateLoaded(procurements: procurements, ids: ids));
  }
}
