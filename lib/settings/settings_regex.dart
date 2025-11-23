class SettingsRegex {
  static const valueNotZero = r'^(?!0*(\.0+)?$)(\d+|\d*\.\d+)$';
  static const intFormatLimit = r'^[0-9]*$';
  static const numberFormatLimit = r'^[0-9\.\-\/]+$';
}