import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/main.dart';
import 'package:marketplace/router/supplier_router.dart';
import 'package:marketplace/shared/data/offer.dart';
import 'package:marketplace/shared/div.dart';
import 'package:marketplace/shared/dropdown_popup/dropdown_item.dart';
import 'package:marketplace/shared/dropdown_popup/dropdown_popup.dart';

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

class _OfferModal extends StatefulWidget {
  const _OfferModal({Key? key, required this.offer, required this.ref}) : super(key: key);
  final Offer offer;
  final DocumentReference<Map<String, dynamic>> ref;

  @override
  State<_OfferModal> createState() => _OfferModalState();
}

class _OfferModalState extends State<_OfferModal> {
  late TextEditingController _price;
  late TextEditingController _paymentMethode;
  late TextEditingController _currency;
  late TextEditingController _possibleDate;
  late TextEditingController _comment;
  final currencyKey = GlobalKey();

  @override
  void initState() {
    _price = TextEditingController(text: widget.offer.price);
    _paymentMethode = TextEditingController(text: widget.offer.paymentMethode);
    _currency = TextEditingController(text: widget.offer.currency);
    _possibleDate = TextEditingController(text: widget.offer.possibleDate);
    _comment = TextEditingController(text: widget.offer.comment);
    // TODO: implement initState
    super.initState();
  }

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
          Text(widget.offer.productName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 40, color: Colors.black)),
          Container(height: 20),
          Row(children: const [Div()]),
          Container(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _OfferField(controller: _price, label: 'Стоимость')),
              Container(width: 10),
              Column(
                children: [
                  const Text('',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
                  Container(
                    height: 10,
                  ),
                  GestureDetector(
                    key: currencyKey,
                    onTap: () async {
                      final val = await openDropdown(
                          navigatorKey.currentContext!,
                          currencyKey,
                          [
                            DropdownItem(
                                child: Container(
                                  width: 80,
                                  padding: const EdgeInsets.all(5),
                                  child: const Text(
                                    '₽',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                value: '₽'),
                            DropdownItem(
                                child: Container(
                                  width: 80,
                                  padding: const EdgeInsets.all(5),
                                  child: const Text(
                                    r'$',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                value: r'$'),
                            DropdownItem(
                                child: Container(
                                  width: 80,
                                  padding: const EdgeInsets.all(5),
                                  child: const Text(
                                    '€',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                value: '€'),
                          ],
                          10);

                      if (val != null) {
                        _currency.text = val;
                      }
                    },
                    child: Container(
                      height: 55,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        color: const Color.fromRGBO(243, 243, 243, 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_currency.text,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color: Color.fromRGBO(153, 153, 153, 1),
                              )),
                          const Icon(
                            Icons.expand_more,
                            size: 30,
                            color: Color.fromRGBO(153, 153, 153, 1),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(width: 25),
              Expanded(child: _OfferField(controller: _paymentMethode, label: 'Способ оплаты')),
            ],
          ),
          Container(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text('Возможный срок',
                        style:
                            TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
                    Container(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                            context: navigatorKey.currentContext!,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2900));

                        if (date != null) {
                          _possibleDate.text = "${date.day}.${date.month}.${date.year}";
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: const Color.fromRGBO(243, 243, 243, 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_possibleDate.text,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Container(height: 20),
          const Text('Коммениарий',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
          Container(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: const Color.fromRGBO(243, 243, 243, 1),
              ),
              padding: const EdgeInsets.all(15),
              child: TextField(
                  controller: _comment,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color.fromRGBO(153, 153, 153, 1),
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  )),
            ),
          ),
          Container(height: 20),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(supplierPath + '/offer-chat', arguments: widget.ref);
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
                    widget.ref
                        .update(Offer(
                                offererName: widget.offer.offererName,
                                price: _price.text,
                                currency: _currency.text,
                                paymentMethode: _paymentMethode.text,
                                possibleDate: _possibleDate.text,
                                comment: _comment.text,
                                productName: widget.offer.productName,
                                productId: widget.offer.productId,
                                offererId: widget.offer.offererId)
                            .toMap())
                        .then((value) => Navigator.of(context).pop());
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
                        'Сохранить изменения',
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
      ),
    );
  }
}

class _OfferField extends StatelessWidget {
  const _OfferField({Key? key, required this.controller, required this.label}) : super(key: key);
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
        Container(height: 10),
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(243, 243, 243, 1),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color.fromRGBO(153, 153, 153, 1),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
