import 'package:flutter/material.dart';
import 'package:marketplace/router/purchaser_router.dart';
import 'package:marketplace/router/router.dart';
import 'package:marketplace/router/supplier_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(supplierPath);
              },
              child: const Text('Supplier')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(purchaserPath);
              },
              child: const Text('Purchaser')),
        ],
      ),
    );
  }
}
