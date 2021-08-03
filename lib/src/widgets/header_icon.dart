import 'package:flutter/material.dart';

class HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: Icon(Icons.lock, color: Colors.white, size: 80),
      ),
    );
  }
}