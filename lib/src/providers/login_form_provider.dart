import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";

  bool isValidated(){
    print(formKey.currentState?.validate()); 
    return formKey.currentState?.validate() ?? false;
  }
}