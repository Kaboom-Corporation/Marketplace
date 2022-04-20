import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/pages/purchaser/procurement/offers_cubit.dart';

import 'package:marketplace/shared/data/offer.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit(this.ref) : super(OffersStateLoading()) {
    getAll();
    getProcurementName();
  }

  DocumentReference<Map<String, dynamic>> ref;
  String procurementName = "";

  void getAll() async {
    List<String> ids = [];
    List<Offer> procurements = await ref.collection('offers').get().then((value) => value.docs.map((e) {
          ids.add(e.id);
          return Offer.fromMap(e.data());
        }).toList());

    emit(OffersStateLoading());
    print('cleaned');
    emit(OffersStateLoaded(offers: procurements, ids: ids));
  }

  void getProcurementName() async {
    procurementName = await ref.get().then((value) => value['name']);
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
