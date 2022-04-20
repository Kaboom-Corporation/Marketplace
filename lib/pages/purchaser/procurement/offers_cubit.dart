import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marketplace/shared/data/offer.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit(this.procurementId) : super(OffersStateLoading()) {
    getAll();
  }

  String procurementId;

  void getAll() async {
    List<String> ids = [];
    List<Offer> procurements = await FirebaseFirestore.instance
        .collection('purchasers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('procurements')
        .doc(procurementId)
        .collection('offers')
        .get()
        .then((value) => value.docs.map((e) {
              ids.add(e.id);
              return Offer.fromMap(e.data());
            }).toList());

    emit(OffersStateLoaded(offers: procurements, ids: ids));
  }
}

abstract class OffersState {}

class OffersStateLoading extends OffersState {}

class OffersStateLoaded extends OffersState {
  List<Offer> offers;
  List<String> ids;
  OffersStateLoaded({
    required this.offers,
    required this.ids,
  });
}
