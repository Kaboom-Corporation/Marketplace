import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:marketplace/shared/data/procurement.dart';

abstract class ProcurementsState {}

class ProcurementsStateLoading extends ProcurementsState {}

class ProcurementsStateLoaded extends ProcurementsState {
  List<Procurement> procurements;
  ProcurementsStateLoaded({
    required this.procurements,
  });

  // Stream<QuerySnapshot<Map<String, dynamic>>> proqurements;
  // DirectChatLoaded({
  //   required this.userPreview,
  //   required this.messageSnapshotsStream,
  // });
}
