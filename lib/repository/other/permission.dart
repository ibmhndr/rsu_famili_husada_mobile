import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/string/string_data.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/styles/dialog.dart';

Future<dynamic> getLocationPermission(BuildContext context, Function func,
    {Function? failedFunct}) async {
  if (await Permission.location.request().isGranted) {
    if (kDebugMode) {
      print("Permission location granted continue");
    }

    return func();
  } else {
    //@Execute on failed funct
    if (failedFunct != null) {
      failedFunct();
    }

    if (context.mounted) {
      showConfirmDialog(
        context,
        HeaderDialog.errorAksesDialog("Lokasi"),
        MessageDialog.permissionDisabled("lokasi"),
        ActionDialog.ok,
        Theme.of(context).colorScheme.primary,
        functionOnOk: () => openAppSettings(),
      );
    }
  }
}

Future<dynamic> getCameraPermission(BuildContext context, Function func,
    {Function? failedFunct}) async {
  if (await Permission.camera.request().isGranted) {
    if (kDebugMode) {
      print("Permission camera granted go to menu");
    }

    return func();
  } else {
    //@Execute on failed funct
    if (failedFunct != null) {
      failedFunct();
    }

    if (context.mounted) {
      showConfirmDialog(
        context,
        HeaderDialog.errorAksesDialog("Kamera"),
        MessageDialog.permissionDisabled("kamera"),
        ActionDialog.ok,
        Theme.of(context).colorScheme.primary,
        functionOnOk: () => openAppSettings(),
      );
    }
  }
}
