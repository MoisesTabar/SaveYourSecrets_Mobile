import 'package:flutter/material.dart';
import 'package:save_your_secrets/src/widgets/widgets.dart';

class LoginBackgroundBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0,5),
            )
          ]
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text('Iniciar Sesión', style: Theme.of(context).textTheme.headline4),
            SizedBox(height: 30),
            LoginForm()
          ],
        ),
      ),
    );
  }
}