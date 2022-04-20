import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/pages/purchaser/procurement/offers_cubit.dart';
import 'package:marketplace/pages/purchaser/procurement/procurement_nav.dart';
import 'package:marketplace/router/purchaser_router.dart';
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('Пердложения', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 50)),
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
              id: s.ids[id],
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
  const _OffersListItem({Key? key, required this.offer, required this.id}) : super(key: key);
  final Offer offer;
  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(purchaserPath + '/procurement-info', arguments: id);
      },
      child: SizedBox(
        height: 145,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.20),
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: 85,
              width: 250,
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
          ],
        ),
      ),
    );
  }
}
