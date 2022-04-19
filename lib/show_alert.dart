import 'package:flutter/material.dart';
import 'package:marketplace/main.dart';

showAlert(String text) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (d) => Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            // color: AppTheme.of(context).customColors.turnFeedbackFormBackgroungShadow,
            child: GestureDetector(
              onTap: () {
                Navigator.of(navigatorKey.currentContext!).pop();
              },
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
              padding: const EdgeInsets.all(15),
              height: 300,
              width: 500,
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    barrierColor: const Color.fromRGBO(96, 89, 238, 0.1),
  );
}
