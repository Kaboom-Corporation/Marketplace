import 'package:flutter/material.dart';
import 'package:marketplace/shared/side_nav.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideNav(),
          Expanded(
              child: Container(
            color: Colors.grey,
          )),
        ],
      ),
    );
  }
}
