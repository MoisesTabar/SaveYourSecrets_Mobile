import 'package:flutter/material.dart';
import 'dart:math' as math;

class SecretsList extends StatelessWidget {

  late final String name;
  late final String description;

  SecretsList({
    required this.name,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.primaries[math.Random().nextInt(Colors.primaries.length)],
              Colors.primaries[math.Random().nextInt(Colors.primaries.length)]
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft 
          ),
          borderRadius: BorderRadius.circular(15)
        ), 
        child: Padding(
          padding: EdgeInsets.all(11),
          child: Stack(
            children: [
              Text(
                name, 
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold, 
                  fontSize: 20
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  description,
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 16
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}