import 'package:flutter/material.dart';
import 'package:marketplace/shared/side_nav_purchaser.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideNavPurchaser(),
          Expanded(
              child: Container(
            color: Colors.grey,
          )),
        ],
      ),
    );
  }
}
