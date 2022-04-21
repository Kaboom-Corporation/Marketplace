import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/shared/div.dart';
import 'package:marketplace/shared/side_nav_purchaser.dart';
import 'package:marketplace/shared/side_nav_supplier.dart';
import 'package:marketplace/show_alert.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
                  child: const _ProfileSection())),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatefulWidget {
  const _ProfileSection({Key? key}) : super(key: key);

  @override
  State<_ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<_ProfileSection> {
  TextEditingController _name = TextEditingController();
  TextEditingController _surname = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _orgnisation = TextEditingController();
  TextEditingController _itin = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance.collection('suppliers').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      setState(() {
        _name.text = value["name"];
        _surname.text = value['surname'];
        _lastName.text = value['lastName'];
        _orgnisation.text = value['organisationName'];
        _itin.text = value['itin'];
      });
    });
  }

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
              Text('Профиль', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 50)),
            ],
          ),
          Container(height: 30),
          Row(
            children: const [
              Div(),
            ],
          ),
          Container(height: 30),
          _ProfileField(controller: _name, label: 'Имя'),
          Container(height: 20),
          _ProfileField(controller: _surname, label: 'Фамилия'),
          Container(height: 20),
          _ProfileField(controller: _lastName, label: 'Отчкство'),
          Container(height: 20),
          _ProfileField(controller: _orgnisation, label: 'Название организации'),
          Container(height: 20),
          _ProfileField(controller: _itin, label: 'ИНН'),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () {
              FirebaseFirestore.instance.collection('suppliers').doc(FirebaseAuth.instance.currentUser!.uid).update({
                'name': _name.text,
                'surname': _surname.text,
                'lastName': _lastName.text,
                'organisationName': _orgnisation.text,
                'itin': _itin.text,
              });

              showAlert('Данные изменены');
            },
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(96, 89, 238, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Center(
                  child: Text('Сохранить изменения',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({Key? key, required this.controller, required this.label}) : super(key: key);
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
