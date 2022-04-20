import 'package:flutter/material.dart';
import 'package:marketplace/router/router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/supplier');
              },
              child: const Text('Supplier')),
          ElevatedButton(
              onPressed: () {
                print('object');
                Navigator.of(context).pushNamed(purchaserPath);
              },
              child: const Text('Purchaser')),
        ],
      ),
    );
  }
}
