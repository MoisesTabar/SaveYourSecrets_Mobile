import 'package:flutter/material.dart';
import 'package:save_your_secrets/src/utils/formfield_util.dart';

class CustomTextFormField extends StatefulWidget {

  late final List<String?>? inputDecorationTexts;
  late final IconData? inputDecorationIcon;
  late final TextInputType? inputType;
  late final Function(String value) inputOnChanged;

  CustomTextFormField({
    required this.inputDecorationTexts,
    required this.inputDecorationIcon,
    required this.inputType,
    required this.inputOnChanged
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      autocorrect: false,
      keyboardType: widget.inputType,
      onChanged: (value) => widget.inputOnChanged(value),
      decoration: FormFieldDecorations.loginInputDecoration(
        widget.inputDecorationTexts![0]!, 
        widget.inputDecorationTexts![1]!, 
        widget.inputDecorationIcon!
      ),
      style: TextStyle(
        color: Colors.white,
      ),
      validator: (value){
        return value != null && value.length >= 1
        ? null
        : 'Este campo no puede ser nulo';
      }
    );
  }
}