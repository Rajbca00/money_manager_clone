import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.controller,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.isPassword,
      this.enabled,
      this.readOnly,
      this.borderColor,
      this.keyboardType,
      this.helpText,
      this.errorText,
      this.onTap,
      this.initialValue});

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final Icon prefixIcon;
  final Icon suffixIcon;
  final bool isPassword;
  final bool enabled;
  final bool readOnly;
  final Color borderColor;
  final String helpText;
  final String errorText;
  final String initialValue;
  final Function onTap;
  final TextInputType keyboardType;

  Widget get getTextFormField {
    print(controller.text);
    return TextFormField(
        controller: controller,
        onChanged: (value) {
          print(value);
        },
        onTap: () {
          onTap != null ? onTap(true) : null;
        },
        validator: errorText == null
            ? null
            : (value) {
                if (value == null || value.isEmpty) {
                  return errorText;
                }
                return null;
              },
        readOnly: null == readOnly ? false : readOnly,
        obscureText: null == isPassword ? false : isPassword,
        style: TextStyle(color: Colors.grey[200], fontSize: 16),
        keyboardType: keyboardType,
        decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: null == hintText ? '' : hintText,
            errorText: null,
            //labelText: null == labelText ? '' : labelText,
            helperText: null == helpText ? null : helpText,
            prefixIcon: null == prefixIcon ? null : prefixIcon,
            hintStyle: TextStyle(color: Colors.grey[200]),
            enabled: null == enabled ? true : enabled,
            floatingLabelBehavior: labelText != null
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.never,
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey[400], width: 1)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent, width: 1)),
            enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.blueGrey[400], width: 1))));
  }

  @override
  Widget build(BuildContext context) {
    return labelText != null
        ? Row(
            children: [
              Container(
                width: 75,
                child: Text(
                  labelText,
                  style: TextStyle(color: Colors.grey[200], fontSize: 14),
                ),
              ),
              SizedBox(width: 20),
              Expanded(child: getTextFormField),
            ],
          )
        : getTextFormField;
  }
}
