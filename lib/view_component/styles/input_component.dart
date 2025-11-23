import 'package:flutter/material.dart';

textFieldDecoration({required BuildContext context, required String hintText,
  required Color textColor, required Color fillColor, required Color borderColor, bool isHintDefault=true, String prefixText = '', String suffixText = ''}) {
  return InputDecoration(
    labelStyle: TextStyle(
      color: textColor
    ),
    prefixText: prefixText,
    suffixText: suffixText,
    filled: true,
    fillColor: fillColor,
    hintText: isHintDefault
      ? 'Contoh : $hintText'
      : hintText,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor, width: 2.0),
      borderRadius: BorderRadius.circular(12)
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor, width: 2.0),
      borderRadius: BorderRadius.circular(12)
      //borderRadius: BorderRadius.circular(25.0)
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor
      ),
      borderRadius: BorderRadius.circular(12)
      //borderRadius: BorderRadius.circular(25.0)
    ),
  );
}

textFieldWithSuffixDecoration({required BuildContext context, required String hintText,
  required Color textColor, required Color fillColor, required Color borderColor, required Widget suffixWidget}) {
  return InputDecoration(
    suffixIcon: suffixWidget,
    labelStyle: TextStyle(
      color: textColor
    ),
    filled: true,
    hintText: hintText,
    fillColor: fillColor,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor, width: 2.0
      ),
      borderRadius: BorderRadius.circular(12)
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
          color: borderColor, width: 2.0
      ),
      borderRadius: BorderRadius.circular(12)
      //borderRadius: BorderRadius.circular(25.0)
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor
      ),
      borderRadius: BorderRadius.circular(12)
      //borderRadius: BorderRadius.circular(25.0)
    ),
  );
}