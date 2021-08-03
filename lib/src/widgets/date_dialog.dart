import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DateDialog extends StatefulWidget {
  late String? date;
  late Color? buttonColor;

  DateDialog({
    required this.date,
    required this.buttonColor
  });

  @override
  _DateDialogState createState() => _DateDialogState();
}

class _DateDialogState extends State<DateDialog> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: widget.buttonColor, 
      elevation: 0,
      onPressed: (){
        DatePicker.showDatePicker(
          context,
          theme: DatePickerTheme(
            containerHeight: MediaQuery.of(context).size.height / 2,
            doneStyle: TextStyle(
              color: Colors.indigo.shade600,
              fontWeight: FontWeight.bold,
              fontSize: 17
            ),
            backgroundColor: Colors.white,
            headerColor: Colors.white,
          ),
          showTitleActions: true,
          minTime: DateTime(2000, 1, 1),
          maxTime: DateTime(2040, 1, 1),
          onChanged: (date){
            setState(() => widget.date = date.toLocal().toString().split(' ')[0]);
            print(widget.date);
          },
          currentTime: DateTime.now(), locale: LocaleType.en
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 20,
        child: Row(
          children: [
             Container(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.date_range,
                    size: 18.0,
                    color: Colors.white,
                  ),
                  Text(
                    "${widget.date}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}