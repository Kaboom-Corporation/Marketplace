import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marketplace/shared/data/offer.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit(this.ref) : super(OffersStateLoading()) {
    getAll();
  }

  DocumentReference<Map<String, dynamic>> ref;

  void getAll() async {
    List<DocumentReference<Map<String, dynamic>>> refs = [];
    List<Offer> procurements = await ref.collection('offers').get().then((value) => value.docs.map((e) {
          refs.add(e.reference);
          return Offer.fromMap(e.data());
        }).toList());

    emit(OffersStateLoaded(offers: procurements, refs: refs));
  }
}

abstract class OffersState {}

class OffersStateLoading extends OffersState {}

class OffersStateLoaded extends OffersState {
  List<Offer> offers;
  List<DocumentReference<Map<String, dynamic>>> refs;
  OffersStateLoaded({
    required this.offers,
    required this.refs,
  });
}
