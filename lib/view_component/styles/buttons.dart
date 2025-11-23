import 'package:flutter/material.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/styles/colors.dart';

//=======BUTTON STYLE======
//Button Success
ButtonStyle buttonCustom(double radius, double elevation, Color color,
    {double padding = 12}) {
  return ButtonStyle(
    elevation: MaterialStateProperty.all(elevation),
    backgroundColor: MaterialStateProperty.all(color),
    padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
    shadowColor: MaterialStateProperty.all(colorAccentGrey().withOpacity(0.2)),
    //if(height != null && width != null) fixedSize: MaterialStateProperty.all(Size(height, width))
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      //side: BorderSide(color: Colors.red)
    )),
  );
}

//Button Secondary
ButtonStyle buttonSecondary(double radius, double width, double elevation,
    Color mainColor, Color backgroundColor,
    {double padding = 12}) {
  return ButtonStyle(
      elevation: MaterialStateProperty.all(elevation),
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(width: width, color: mainColor))));
}

//Button Ok
ButtonStyle buttonOk(double radius, double elevation,
    {double? height, double? width}) {
  return ButtonStyle(
      elevation: MaterialStateProperty.all(elevation),
      backgroundColor: MaterialStateProperty.all(Colors.blue),
      //if(height != null && width != null) fixedSize: MaterialStateProperty.all(Size(height, width))
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        //side: BorderSide(color: Colors.red)
      )));
}

//Button Ok
ButtonStyle buttonError(double radius, double elevation,
    {double padding = 12}) {
  return ButtonStyle(
      elevation: MaterialStateProperty.all(elevation),
      backgroundColor: MaterialStateProperty.all(Colors.red),
      //if(height != null && width != null) fixedSize: MaterialStateProperty.all(Size(height, width))
      padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        //side: BorderSide(color: Colors.red)
      )));
}

//Button Deactive
ButtonStyle buttonDeactive(double radius, double elevation,
    {double? height, double? width}) {
  return ButtonStyle(
      elevation: MaterialStateProperty.all(elevation),
      backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
      //if(height != null && width != null) fixedSize: MaterialStateProperty.all(Size(height, width))
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        //side: BorderSide(color: Colors.red)
      )));
}
