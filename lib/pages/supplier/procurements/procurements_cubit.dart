import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/pages/supplier/procurements/procurements_states.dart';
import 'package:marketplace/shared/data/procurement.dart';

class ProcurementsCubit extends Cubit<ProcurementsState> {
  ProcurementsCubit() : super(ProcurementsStateLoading()) {
    getAll();
  }

  void getAll() async {
    List<DocumentReference<Map<String, dynamic>>> refs = [];
    List<Procurement> procurements =
        await FirebaseFirestore.instance.collectionGroup('procurements').get().then((value) => value.docs.map((e) {
              refs.add(e.reference);
              return Procurement.fromMap(e.data());
            }).toList());

    emit(ProcurementsStateLoaded(procurements: procurements, refs: refs));
  }
}
