import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/consts.dart';
import 'package:marketplace/pages/supplier/procurement/procurement_cubit.dart';
import 'package:marketplace/router/supplier_router.dart';
import 'package:marketplace/router/router.dart';

class ProcurementNav extends StatefulWidget {
  const ProcurementNav({Key? key}) : super(key: key);

  @override
  State<ProcurementNav> createState() => _ProcurementNavState();
}

class _ProcurementNavState extends State<ProcurementNav> {
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
                child: Image.network(logoPath, isAntiAlias: true, fit: BoxFit.contain),
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
            children: [
              const _SideNavItem(
                route: supplierPath + '/procurements',
                label: 'Назад',
                icon: Icons.arrow_back,
              ),
              _SideNavItem(
                route: supplierPath + '/procurement-info',
                label: 'Информация',
                icon: Icons.info,
                argumentOption: BlocProvider.of<ProcurementCubit>(context).ref,
              ),
              _SideNavItem(
                route: supplierPath + '/procurement-offers',
                label: 'Предложения',
                icon: Icons.local_offer,
                argumentOption: BlocProvider.of<ProcurementCubit>(context).ref,
              ),
            ],
          ),
          Container(
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut().then((value) => Navigator.of(context).pushNamedAndRemoveUntil(
                          supplierPath + '/auth',
                          (route) => false,
                        ));
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
  const _SideNavItem({Key? key, required this.route, required this.label, required this.icon, this.argumentOption})
      : super(key: key);
  final String route;
  final String label;
  final IconData icon;
  final Object? argumentOption;

  @override
  Widget build(BuildContext context) {
    final isSelected = route == ModalRoute.of(context)!.settings.name;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route, arguments: argumentOption);
      },
      child: Container(
        height: 70,
        color: isSelected ? const Color.fromRGBO(96, 89, 238, 1) : Colors.white,
        child: Row(
          children: [
            Container(width: 25),
            Icon(icon, size: 30, color: isSelected ? Colors.white : Colors.black),
            Container(width: 15),
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 23, color: isSelected ? Colors.white : Colors.black)),
          ],
        ),
      ),
    );
  }
}
