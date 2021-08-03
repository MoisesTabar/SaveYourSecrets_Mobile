import 'package:flutter/material.dart';

class FormFieldDecorations{
  static InputDecoration loginInputDecoration(String hintText, String labelText, IconData icon){
    return InputDecoration( 
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.indigo.shade600
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.indigo.shade600,
          width: 2
        )
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.indigo.shade300
      ),
      prefixIcon: Icon(icon, color: Colors.indigo.shade600)
    );
  }
}