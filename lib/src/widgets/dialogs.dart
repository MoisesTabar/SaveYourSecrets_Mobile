import 'package:flutter/material.dart';

class Dialogs extends StatelessWidget {

  late final String dialogTitle;
  late final String dialogContent;
  late final String buttonContent;
  late final IconData dialogIcon;
  late final Color dialogHeaderColor;
  late final dynamic Function() onButtonPressed;

  Dialogs({
    required this.dialogTitle,
    required this.dialogContent,
    required this.dialogIcon,
    required this.dialogHeaderColor,
    required this.onButtonPressed,
    required this.buttonContent
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 2,
      insetAnimationCurve: Curves.easeOutCubic,
      insetAnimationDuration: Duration(milliseconds: 500),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            color: Colors.white,
          ),
          Container(
            color: dialogHeaderColor,
            width: double.infinity,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(dialogIcon, color: dialogHeaderColor)
                ),
                SizedBox(height: 10),
                Text(
                  dialogTitle, 
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ),
          Positioned(
            top: 235,
            left: MediaQuery.of(context).size.width / 5.5,
            child: Text(dialogContent, textAlign: TextAlign.center)
          ),
          Positioned(
            top: 260,
            left: MediaQuery.of(context).size.width / 3.5,
            child: MaterialButton(
              color: dialogHeaderColor,
              onPressed: onButtonPressed,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
              child: Text(buttonContent, style: TextStyle(color: Colors.white)),
            ) 
          )
        ],
      ),
    );
  }
}