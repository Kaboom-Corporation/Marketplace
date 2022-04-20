import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/main.dart';
import 'package:marketplace/shared/data/offer.dart';
import 'package:marketplace/shared/div.dart';
import 'package:marketplace/shared/dropdown_popup/dropdown_item.dart';
import 'package:marketplace/shared/dropdown_popup/dropdown_popup.dart';

showAddOffer(String procurementName, String procurementId, DocumentReference<Map<String, dynamic>> ref) async {
  TextEditingController _price = TextEditingController();
  TextEditingController _paymentMethode = TextEditingController();
  TextEditingController _currency = TextEditingController(text: "₽");
  TextEditingController _possibleDate = TextEditingController();
  TextEditingController _comment = TextEditingController();
  String offererName;
  final currencyKey = GlobalKey();

  await showDialog(
    context: navigatorKey.currentContext!,
    builder: (d) => AddOfferWidget(
      procRef: ref,
      procurementName: procurementName,
      price: _price,
      currencyKey: currencyKey,
      currency: _currency,
      paymentMethode: _paymentMethode,
      possibleDate: _possibleDate,
      comment: _comment,
      procuremId: procurementId,
    ),
    barrierColor: const Color.fromRGBO(96, 89, 238, 0.1),
  );
}

class AddOfferWidget extends StatefulWidget {
  const AddOfferWidget(
      {Key? key,
      required TextEditingController price,
      required this.currencyKey,
      required TextEditingController currency,
      required TextEditingController paymentMethode,
      required TextEditingController possibleDate,
      required TextEditingController comment,
      required this.procuremId,
      required this.procRef,
      required this.procurementName})
      : _price = price,
        _currency = currency,
        _paymentMethode = paymentMethode,
        _possibleDate = possibleDate,
        _comment = comment,
        super(key: key);

  final TextEditingController _price;
  final GlobalKey<State<StatefulWidget>> currencyKey;
  final TextEditingController _currency;
  final TextEditingController _paymentMethode;
  final TextEditingController _possibleDate;
  final TextEditingController _comment;
  final String procuremId;
  final DocumentReference<Map<String, dynamic>> procRef;

  final String procurementName;

  @override
  State<AddOfferWidget> createState() => _AddOfferWidgetState();
}

class _AddOfferWidgetState extends State<AddOfferWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            // color: AppTheme.of(context).customColors.turnFeedbackFormBackgroungShadow,
            child: GestureDetector(
              onTap: () {
                Navigator.of(navigatorKey.currentContext!).pop();
              },
            ),
          ),
          Center(
            child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
                padding: const EdgeInsets.all(15),
                height: 700,
                width: 1000,
                child: Column(
                  children: [
                    Text(widget.procurementName,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 40, color: Colors.black)),
                    Container(height: 20),
                    Row(children: const [Div()]),
                    Container(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _OfferField(controller: widget._price, label: 'Стоимость')),
                        Container(width: 10),
                        Column(
                          children: [
                            const Text('',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
                            Container(
                              height: 10,
                            ),
                            GestureDetector(
                              key: widget.currencyKey,
                              onTap: () async {
                                final val = await openDropdown(
                                    navigatorKey.currentContext!,
                                    widget.currencyKey,
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
                                  widget._currency.text = val;
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
                                    Text(widget._currency.text,
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
                        Expanded(child: _OfferField(controller: widget._paymentMethode, label: 'Способ оплаты')),
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
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
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
                                    widget._possibleDate.text = "${date.day}.${date.month}.${date.year}";
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
                                      Text(widget._possibleDate.text,
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
                        style:
                            TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
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
                            controller: widget._comment,
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
                    GestureDetector(
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection('suppliers')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get()
                            .then((value) {
                          widget.procRef.collection('offers').add(Offer(
                                  offererName: value["organisationName"],
                                  price: widget._price.text,
                                  currency: widget._currency.text,
                                  paymentMethode: widget._paymentMethode.text,
                                  possibleDate: widget._possibleDate.text,
                                  comment: widget._comment.text,
                                  productName: widget.procurementName,
                                  productId: widget.procuremId)
                              .toMap());
                        }).then((value) => {Navigator.of(context).pop()});
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(96, 89, 238, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Center(
                            child: Text('Создать запрос',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white))),
                      ),
                    )
                  ],
                )),
          ),
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
