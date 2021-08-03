import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_your_secrets/src/providers/login_form_provider.dart';
import 'package:save_your_secrets/src/utils/formfield_util.dart';

class LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   final loginFormProvider = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginFormProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => loginFormProvider.email = value,
              decoration: FormFieldDecorations.loginInputDecoration('Juan@hotmail.com', 'Correo electrónico', Icons.email),
              validator: (value){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);

                return regExp.hasMatch(value ?? '') ? null : 'Correo no valido';
              }
            ),
            SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              onChanged: (value) => loginFormProvider.password = value,
              decoration: FormFieldDecorations.loginInputDecoration('****', 'Contraseña', Icons.lock_rounded),
              validator: (value){
                return value != null && value.length >= 8 
                ? null
                : 'La contraseña debe ser de más de 8 caracteres';
              },
            ),
            SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.indigo.shade600,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text('Iniciar Sesión', style: TextStyle(color: Colors.white))
              ),
              onPressed: (){
                if(!loginFormProvider.isValidated()) return;

                Navigator.pushReplacementNamed(context, 'home');
              },
            )
          ]
        ),
      ),     
    );
  }
}