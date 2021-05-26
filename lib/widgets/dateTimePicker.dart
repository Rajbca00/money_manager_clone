import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class CustomDateTimePicker extends StatelessWidget {
  final String label;
  final DateFormat dateFormat;
  final TextEditingController controller;

  CustomDateTimePicker({this.label, this.controller, this.dateFormat});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 75,
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[200], fontSize: 16),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: DateTimeField(
            controller: controller,
            readOnly: true,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
            format: dateFormat,
            decoration: InputDecoration(
                fillColor: Colors.white,
                hintStyle: TextStyle(color: Colors.grey[200]),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueGrey[400], width: 1)),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueGrey[400], width: 1)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueGrey[400], width: 1))),
            resetIcon: Icon(
              Icons.delete,
              color: Colors.grey[400],
            ),
            onShowPicker: (context, currentValue) async {
              final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.combine(date, time);
              } else {
                return currentValue;
              }
            },
          ),
        ),
      ],
    );
  }
}
