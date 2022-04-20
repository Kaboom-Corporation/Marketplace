import 'package:flutter/material.dart';

class Div extends StatelessWidget {
  const Div({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 2,
      width: 2,
      color: const Color.fromRGBO(225, 225, 225, 1),
    ));
  }
}
