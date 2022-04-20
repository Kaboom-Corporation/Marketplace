import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:marketplace/consts.dart';
import 'package:marketplace/router/supplier_router.dart';
import 'package:marketplace/router/router.dart';

class SideNavSupplier extends StatefulWidget {
  const SideNavSupplier({Key? key}) : super(key: key);

  @override
  State<SideNavSupplier> createState() => _SideNavSupplierState();
}

class _SideNavSupplierState extends State<SideNavSupplier> {
  String organisationName = "...";
  String itin = "...";

  @override
  void initState() {
    initInfo();

    super.initState();
  }

  initInfo() async {
    FirebaseFirestore.instance.collection('suppliers').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      setState(() {
        itin = value["itin"];
        organisationName = value["organisationName"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 35),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: Image.asset(logoPath, isAntiAlias: true, fit: BoxFit.contain),
              ),
              Container(width: 3),
              Column(
                children: const [
                  Text('Торги', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30)),
                  Text('Исполнитель',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Color.fromRGBO(215, 59, 29, 1))),
                ],
              )
            ],
          ),
          Column(
            children: const [
              _SideNavItem(route: supplierPath + '/procurements', label: 'Запросы', icon: Icons.shopping_cart),
              _SideNavItem(route: supplierPath + '/my-offers', label: 'Мои предложения', icon: Icons.local_offer),
              _SideNavItem(route: supplierPath + '/profile', label: 'Профиль', icon: Icons.person),
            ],
          ),
          Container(
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(organisationName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20, color: Color.fromRGBO(28, 55, 88, 1))),
                Text("ИНН: " + itin,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20, color: Color.fromRGBO(164, 164, 164, 1))),
                Container(height: 10),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut().then((value) =>
                        Navigator.of(context).pushNamedAndRemoveUntil(supplierPath + '/auth', (route) => false));
                  },
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: const Color.fromRGBO(235, 235, 235, 1)),
                    child: const Center(
                      child: Text("Выйти",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20, color: Color.fromRGBO(164, 164, 164, 1))),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SideNavItem extends StatelessWidget {
  const _SideNavItem({
    Key? key,
    required this.route,
    required this.label,
    required this.icon,
  }) : super(key: key);
  final String route;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final isSelected = route == ModalRoute.of(context)!.settings.name;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
        height: 70,
        color: isSelected ? const Color.fromRGBO(96, 89, 238, 1) : Colors.white,
        child: Row(
          children: [
            Container(width: 25),
            Icon(icon, size: 30, color: isSelected ? Colors.white : Colors.black),
            Container(width: 15),
            Expanded(
              child: AutoSizeText(label,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 23, color: isSelected ? Colors.white : Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
