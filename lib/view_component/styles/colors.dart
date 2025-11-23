import 'package:flutter/material.dart';

//======COLOR======
//Top Color
Color colorWhite() {
  return Colors.white;
}

Color colorCream() {
  return const Color(0xfffdfded);
}

//Top Color
Color colorAccentWhite() {
  return const Color(0xfff7f7f7);
}

//Accent Button
Color colorAccentGrey() {
  return const Color(0xff9c9c9c);
}

Color colorDarkRed() {
  return const Color(0xffaa0000);
}

Color colorAccentOrange() {
  return const Color(0xfff0ad4e);
}

Color colorAccentRed() {
  return const Color(0xffd9534f);
}

Color colorBlue() {
  return const Color(0xff428bcb);
}

Color colorAccentBlue() {
  return const Color(0xffECF9FF);
}

Color colorAccentGreen() {
  return const Color(0xff5db85b);
}

//@Alternate Black
Color colorBlack() {
  return const Color(0xff616161);
}

Color colorBlackPrimary() {
  return const Color(0xff313131);
}

Color colorBlackSecondary() {
  return const Color(0xff919191);
}

//======TEXTFIELD COLOR======
//@Colors Textfield
Color textFieldColor() {
  return Colors.grey.shade200;
}

//@Color Textfield Disabled
Color textFieldColorDisabled() {
  return Colors.grey.shade400;
}

Map<String, dynamic> listColorAntrean = {
  'danger': colorAccentRed(),
  'primary': colorBlue(),
  'success': colorAccentGreen(),
  'warning': colorAccentOrange(),
  '': colorAccentGrey()
};
