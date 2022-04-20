import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/pages/supplier/procurement/procurement_cubit.dart';
import 'package:marketplace/pages/supplier/procurement/procurement_nav.dart';
import 'package:marketplace/shared/data/procurement.dart';
import 'package:marketplace/shared/div.dart';

class ProcurementInfoPage extends StatelessWidget {
  const ProcurementInfoPage({Key? key}) : super(key: key);

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
                  child: BlocBuilder<ProcurementCubit, ProcurementState>(builder: (c, s) {
                    if (s is ProcurementStateLoaded) {
                      return ProcurementFrame(
                          id: s.ref.id,
                          procurementType: s.procurement.procurementType == "auction"
                              ? ProcurementType.Fixed
                              : ProcurementType.Auction,
                          name: s.procurement.name,
                          quantity: s.procurement.quantity,
                          price: s.procurement.price,
                          currency: s.procurement.currency,
                          paymentMethod: s.procurement.paymentMethod,
                          productType: s.procurement.productType,
                          endDate: s.procurement.endDate,
                          deliveryAddress: s.procurement.deliveryAddress,
                          comment: s.procurement.comment);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }))),
        ],
      ),
    );
  }
}

class ProcurementFrame extends StatelessWidget {
  const ProcurementFrame({
    Key? key,
    required this.id,
    required this.procurementType,
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
    required this.paymentMethod,
    required this.productType,
    required this.endDate,
    required this.deliveryAddress,
    required this.comment,
  }) : super(key: key);

  final String id;

  final ProcurementType procurementType;
  final String name;
  final String quantity;
  final String price;
  final String currency;
  final String paymentMethod;
  final String productType;
  final String endDate;
  final String deliveryAddress;
  final String comment;

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
              Text(procurementType == ProcurementType.Auction ? "Аукцион" : 'Закупка',
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 50)),
              Container(
                width: 20,
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
          _ProcurementField(controller: name, label: 'Наименование продукта или услуги'),
          Container(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _ProcurementField(controller: quantity, label: 'Количество')),
              Container(width: 25),
              Expanded(child: _ProcurementField(controller: price, label: 'Стоимость')),
              Container(width: 10),
              Column(
                children: [
                  const Text('',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Color.fromRGBO(49, 49, 49, 1))),
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: 55,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: const Color.fromRGBO(243, 243, 243, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(currency,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Color.fromRGBO(153, 153, 153, 1),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Container(width: 25),
              Expanded(child: _ProcurementField(controller: paymentMethod, label: 'Способ оплаты')),
            ],
          ),
          Container(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _ProcurementField(controller: productType, label: 'Тип продукции')),
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
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: const Color.fromRGBO(243, 243, 243, 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(endDate,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Container(width: 25),
              Expanded(child: _ProcurementField(controller: deliveryAddress, label: 'Адрес доставки')),
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
              child: Text(
                comment,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: Color.fromRGBO(153, 153, 153, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcurementField extends StatelessWidget {
  const _ProcurementField({Key? key, required this.controller, required this.label}) : super(key: key);
  final String controller;
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
            child: Text(
              controller,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color.fromRGBO(153, 153, 153, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
