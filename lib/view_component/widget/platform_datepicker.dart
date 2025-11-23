//=======DATE PICKER======
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

Future showDatePickerCustom(BuildContext context, DateTime initialDate, DateTime firstDate, DateTime lastDate) {
  return showPlatformDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    material: (context, platformTarget) => MaterialDatePickerData(
      fieldLabelText: "Tanggal Lahir",
      fieldHintText: "Tanggal/Bulan/Tahun",
      confirmText: "GUNAKAN",
      cancelText: "KEMBALI",
      errorFormatText: "Masukan Tanggal yang Sesuai",
      errorInvalidText: "Masukan Tanggal pada Urutan yang Benar",
      helpText: "PILIH TANGGAL LAHIR ANDA",
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).colorScheme.secondary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Theme.of(context).colorScheme.tertiary,
            ),
            dialogBackgroundColor:Colors.white,
          ),
          child: child!,
        );
      },
    ),
    cupertino: (context, platformTarget) => CupertinoDatePickerData(
      lastDate: lastDate,
      cancelLabel: 'Kembali',
      doneLabel: 'Gunakan',
    ),
  );
}