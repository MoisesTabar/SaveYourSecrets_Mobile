import 'package:flutter/material.dart';
import 'package:save_your_secrets/src/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LoginBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 130),
                Text('Save your secrets', style: Theme.of(context).textTheme.headline3),
                SizedBox(height: 40),
                LoginBackgroundBox(),
                SizedBox(height: 30),
                Text(
                  'No tienes una cuenta? Crea una nueva cuenta', 
                  style: TextStyle( 
                    fontSize: 18,
                    fontWeight: FontWeight.bold 
                  ),
                )
              ],
            ),
          ),
        ), 
      ),
    );
  }
}