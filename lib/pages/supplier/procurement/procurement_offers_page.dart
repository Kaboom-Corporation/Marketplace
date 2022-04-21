import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/pages/supplier/offer/offer_modal.dart';
import 'package:marketplace/pages/supplier/procurement/add_offer_modal.dart';
import 'package:marketplace/pages/supplier/procurement/offers_cubit.dart';
import 'package:marketplace/pages/supplier/procurement/procurement_cubit.dart';
import 'package:marketplace/pages/supplier/procurement/procurement_nav.dart';
import 'package:marketplace/router/supplier_router.dart';
import 'package:marketplace/shared/data/offer.dart';
import 'package:marketplace/shared/div.dart';

class ProcurementOffersPage extends StatelessWidget {
  const ProcurementOffersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const ProcurementNav(),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
                  color: const Color.fromRGBO(243, 243, 243, 1),
                  child: const _OffersSection())),
        ],
      ),
    );
  }
}

class _OffersSection extends StatelessWidget {
  const _OffersSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Предложения', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 50)),
              GestureDetector(
                onTap: () async {
                  await showAddOffer(
                      BlocProvider.of<OffersCubit>(context).procurementName,
                      BlocProvider.of<OffersCubit>(context).procurementName,
                      BlocProvider.of<ProcurementCubit>(context).ref);

                  BlocProvider.of<OffersCubit>(context).getAll();
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromRGBO(96, 89, 238, 1),
                  ),
                  child: const Center(
                    child: Text('+ создать свое',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
          Container(height: 30),
          Row(
            children: const [
              Div(),
            ],
          ),
          Container(height: 30),
          const Expanded(child: _ProcurementsList()),
        ],
      ),
    );
  }
}

class _ProcurementsList extends StatelessWidget {
  const _ProcurementsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersCubit, OffersState>(builder: (c, s) {
      if (s is OffersStateLoaded) {
        return ListView.separated(
          itemCount: s.offers.length,
          itemBuilder: (_c, id) {
            return _OffersListItem(
              ref: s.refs[id],
              offer: s.offers[id],
            );
          },
          separatorBuilder: (_c, id) {
            return Row(
              children: [
                Expanded(child: Container()),
                const Div(),
                Expanded(child: Container()),
              ],
            );
          },
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}

class _OffersListItem extends StatelessWidget {
  const _OffersListItem({Key? key, required this.offer, required this.ref}) : super(key: key);
  final Offer offer;
  final DocumentReference<Map<String, dynamic>> ref;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: offer.offererId == FirebaseAuth.instance.currentUser!.uid
          ? () async {
              await showOfferModal(offer, ref);
              BlocProvider.of<OffersCubit>(context).getAll();
            }
          : null,
      child: SizedBox(
        height: 145,
        child: Row(
          children: [
            offer.offererId == FirebaseAuth.instance.currentUser!.uid
                ? Container(
                    height: 20,
                    width: 20,
                    color: Colors.blue,
                  )
                : Container(),
            offer.offererId == FirebaseAuth.instance.currentUser!.uid
                ? Container(
                    width: 20,
                  )
                : Container(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(offer.offererName,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 25, color: Colors.black)),
                Text("Возможная дата: " + offer.possibleDate,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 25, color: Color.fromRGBO(153, 153, 153, 1))),
              ],
            ),
            Expanded(child: Container()),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.20),
                //     blurRadius: 10,
                //   ),
                // ],
              ),
              height: 85,
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Цена", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25, color: Colors.black)),
                  Text(offer.price + offer.currency,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20, color: Color.fromRGBO(200, 200, 200, 1))),
                ],
              ),
            ),
            offer.selected == true ? Container(width: 20) : Container(),
            offer.selected == true
                ? Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green[200],
                    ),
                    child: Center(
                        child: Icon(
                      Icons.emoji_events,
                      size: 40,
                      color: Colors.yellow[200],
                    )),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
