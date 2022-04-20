import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/shared/data/procurement.dart';
import 'package:marketplace/shared/div.dart';
import 'package:marketplace/shared/dropdown_popup/dropdown_item.dart';
import 'package:marketplace/shared/dropdown_popup/dropdown_popup.dart';
import 'package:marketplace/shared/side_nav.dart';

class ProcurementAddPage extends StatelessWidget {
  const ProcurementAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideNav(),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
            color: const Color.fromRGBO(243, 243, 243, 1),
            child: const _AddProcurementSection(),
          )),
        ],
      ),
    );
  }
}

class _AddProcurementSection extends StatefulWidget {
  const _AddProcurementSection({Key? key}) : super(key: key);

  @override
  State<_AddProcurementSection> createState() => _AddProcurementSectionState();
}

class _AddProcurementSectionState extends State<_AddProcurementSection> {
  final buttonKey = GlobalKey();
  ProcurementType procurementType = ProcurementType.Fixed;
  TextEditingController _name = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _currency = TextEditingController(text: "₽");
  TextEditingController _paymentMethod = TextEditingController();
  TextEditingController _productType = TextEditingController();
  TextEditingController _endDate = TextEditingController();
  TextEditingController _deliveryAddress = TextEditingController();
  TextEditingController _comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final typeKey = GlobalKey();
    final currencyKey = GlobalKey();

    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text('Создание запроса', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 50)),
              Container(
                width: 20,
              ),
              GestureDetector(
                key: typeKey,
                onTap: () async {
                  final val = await openDropdown(
                      context,
                      typeKey,
                      [
                        DropdownItem(
                            child: Container(
                              width: 250,
                              padding: const EdgeInsets.all(5),
                              child: const Text(
                                'Закупка',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            value: ProcurementType.Fixed),
                        DropdownItem(
                            child: Container(
                              width: 250,
                              padding: const EdgeInsets.all(5),
                              child: const Text(
                                'Аукцион',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            value: ProcurementType.Auction),
                      ],
                      10);

                  if (val != null && val != procurementType) {
                    setState(() {
                      procurementType = val;
                    });
                  }
                },
                child: Container(
                  height: 55,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    color: const Color.fromRGBO(243, 243, 243, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(procurementType == ProcurementType.Fixed ? 'Закупка' : 'Аукцион',
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
          Container(height: 30),
          Row(
            children: const [
              Div(),
            ],
          ),
          Container(height: 20),
          _ProcurementField(controller: _name, label: 'Наименование продукта или услуги'),
          Container(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _ProcurementField(controller: _quantity, label: 'Количество')),
              Container(width: 25),
              Expanded(child: _ProcurementField(controller: _price, label: 'Стоимость')),
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
                          context,
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
                        setState(() {
                          _currency.text = val;
                        });
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
              Expanded(child: _ProcurementField(controller: _paymentMethod, label: 'Способ оплаты')),
            ],
          ),
          Container(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _ProcurementField(controller: _productType, label: 'Тип продукции')),
              procurementType == ProcurementType.Auction ? Container(width: 25) : Container(),
              procurementType == ProcurementType.Auction
                  ? Expanded(
                      child: Column(
                        children: [
                          const Text('Срок окончания',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
                          Container(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2900));

                              if (date != null) {
                                _endDate.text = "${date.day}.${date.month}.${date.year}";
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
                                  Text(_endDate.text,
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
                    )
                  : Container(),
              Container(width: 25),
              Expanded(child: _ProcurementField(controller: _deliveryAddress, label: 'Адрес доставки')),
            ],
          ),
          Container(height: 15),
          const Text('Комменарий к запросу',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
          Container(height: 10),
          Expanded(
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(243, 243, 243, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _comment,
                minLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: Color.fromRGBO(153, 153, 153, 1),
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(height: 15),
          GestureDetector(
            onTap: () {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get()
                  .then((value) {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('procurements')
                    .add(
                      Procurement(
                              procurementType: procurementType == ProcurementType.Auction ? "auction" : "fixed",
                              name: _name.text,
                              quantity: _quantity.text,
                              price: _price.text,
                              currency: _currency.text,
                              paymentMethod: _paymentMethod.text,
                              productType: _productType.text,
                              endDate: _endDate.text,
                              deliveryAddress: _deliveryAddress.text,
                              comment: _comment.text,
                              organisationName: value["organisationName"])
                          .toMap(),
                    );
              });

              Navigator.of(context).pushNamed('/procurements');
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
          ),
        ],
      ),
    );
  }
}

class _ProcurementField extends StatelessWidget {
  const _ProcurementField({Key? key, required this.controller, required this.label}) : super(key: key);
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
