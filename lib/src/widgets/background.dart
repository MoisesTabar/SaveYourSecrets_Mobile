import 'package:flutter/material.dart';
import 'package:save_your_secrets/src/widgets/widgets.dart';

class LoginBackground extends StatelessWidget {

  late final Widget child;

  LoginBackground({
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          LoginHeader(),
          HeaderIcon(),
          child
        ],
      ),
    );
  }
}