import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/main.dart';
import 'package:marketplace/router/purchaser_router.dart';
import 'package:marketplace/shared/data/offer.dart';
import 'package:marketplace/shared/div.dart';

showOfferModal(Offer offer, DocumentReference<Map<String, dynamic>> ref) async {
  await showDialog(
    context: navigatorKey.currentContext!,
    builder: (d) => Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(navigatorKey.currentContext!).pop();
            },
          ),
          Center(
              child: _OfferModal(
            offer: offer,
            ref: ref,
          )),
        ],
      ),
    ),
    barrierColor: const Color.fromRGBO(96, 89, 238, 0.1),
  );
}

class _OfferModal extends StatelessWidget {
  const _OfferModal({Key? key, required this.offer, required this.ref}) : super(key: key);
  final Offer offer;
  final DocumentReference<Map<String, dynamic>> ref;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.33),
          blurRadius: 40,
        )
      ]),
      padding: const EdgeInsets.all(25),
      height: 700,
      width: 1000,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: Text(offer.offererName,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 35, color: Colors.black)),
                ),
                Column(children: const [Div()]),
                Container(
                  width: 250,
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Цена",
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25, color: Colors.black)),
                        Text(offer.price + offer.currency,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25, color: Color.fromRGBO(153, 153, 153, 1))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 10),
          Row(children: const [Div()]),
          Container(height: 20),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Text("Возможный срок: ",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25, color: Colors.black)),
                  Text(offer.possibleDate,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 25, color: Color.fromRGBO(153, 153, 153, 1))),
                ],
              ),
              Container(height: 20),
              Row(
                children: [
                  const Text("Способ оплаты: ",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25, color: Colors.black)),
                  Text(offer.paymentMethode,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 25, color: Color.fromRGBO(153, 153, 153, 1))),
                ],
              ),
              Container(height: 20),
              const Text("Комментарий: ",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25, color: Colors.black)),
              Container(height: 10),
              Text(offer.comment,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 25, color: Color.fromRGBO(153, 153, 153, 1))),
              Expanded(child: Container()),
              Container(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(purchaserPath + '/offer-chat', arguments: ref);
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(215, 59, 29, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Center(
                          child: Text(
                            'Чат',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ref.update({'selected': true}).then((value) => Navigator.of(context).pop());
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(96, 89, 238, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Center(
                          child: Text(
                            'Назначить победителем',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
