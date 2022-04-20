import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/pages/supplier/procurements/procurements_cubit.dart';
import 'package:marketplace/pages/supplier/procurements/procurements_states.dart';
import 'package:marketplace/router/supplier_router.dart';
import 'package:marketplace/router/router.dart';
import 'package:marketplace/shared/data/procurement.dart';
import 'package:marketplace/shared/div.dart';
import 'package:marketplace/shared/side_nav_supplier.dart';

class ProcurementsPage extends StatelessWidget {
  const ProcurementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideNavSupplier(),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
            color: const Color.fromRGBO(243, 243, 243, 1),
            child: const _ProcurementSection(),
          )),
        ],
      ),
    );
  }
}

class _ProcurementSection extends StatelessWidget {
  const _ProcurementSection({Key? key}) : super(key: key);

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
              Text('Запросы', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 50)),
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
    return BlocBuilder<ProcurementsCubit, ProcurementsState>(builder: (c, s) {
      if (s is ProcurementsStateLoaded) {
        return ListView.separated(
          itemCount: s.procurements.length,
          itemBuilder: (_c, id) {
            return _ProcurementListItem(
              ref: s.refs[id],
              procurement: s.procurements[id],
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

class _ProcurementListItem extends StatelessWidget {
  const _ProcurementListItem({Key? key, required this.procurement, required this.ref}) : super(key: key);
  final Procurement procurement;
  final DocumentReference<Map<String, dynamic>> ref;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(supplierPath + '/procurement-info', arguments: ref);
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
                Text(procurement.organisationName,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 25, color: Colors.black)),
                Text(procurement.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 25, color: Color.fromRGBO(96, 89, 238, 1))),
                Text(procurement.productType,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20, color: Color.fromRGBO(200, 200, 200, 1))),
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
                  Text(
                      procurement.procurementType == "auction"
                          ? "Аукцион"
                          : (procurement.price == "" ? "-" : procurement.price + procurement.currency),
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
