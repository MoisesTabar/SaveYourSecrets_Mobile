import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: _gradientHeader(),
      child: Stack(
        children: [
          Positioned(top: 90, left: 30, child: _dot()),
          Positioned(top: -40, left: -30, child: _dot()),
          Positioned(top: -50, right: -20, child: _dot()),
          Positioned(bottom: -50, left: 10, child: _dot()),
          Positioned(bottom: 120, right: 20, child: _dot()),
        ],
      ),  
    );
  }

  BoxDecoration _gradientHeader() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade400,
          Colors.indigo.shade600,
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft
      ),
    );
  }

  Container _dot() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}