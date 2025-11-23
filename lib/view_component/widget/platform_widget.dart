//=======DATE PICKER======
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:rsufamilyhusadacare_mobile/repository/other/check_dialog.dart';
import 'package:rsufamilyhusadacare_mobile/view/splash_screen/splash_screen.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/string/string_data.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/styles/colors.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/styles/dialog.dart';

class PlatformWidgetApp {
  static Future showDatePickerCustom(BuildContext context, DateTime initialDate,
      DateTime firstDate, DateTime lastDate) {
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
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Theme.of(context)
                    .colorScheme
                    .primary, // header background color
                onPrimary: Colors.white, // header text color
                secondary: Theme.of(context).colorScheme.primary,
                onSecondary: Colors.white,
                onSurface:
                    Theme.of(context).colorScheme.primary, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context)
                      .colorScheme
                      .primary, // button text color
                ),
              ),
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

  static Future<void> showLogOutDialog(BuildContext context) async {
    showMultipleChoiceDialog(
        context: context,
        title: HeaderDialog.confirmDialog("Log Out"),
        content: MessageDialog.confirmProcessData("log out"),
        cancelText: ActionDialog.tidak,
        confirmText: ActionDialog.ya,
        backgroundPrimaryColor: Theme.of(context).colorScheme.primary,
        colorsConfirm: Theme.of(context).colorScheme.primary,
        colorsCancel: colorWhite(),
        isConfirmPrimarySelected: false,
        useRoot: true,
        functionOnConfirm: () async {
          try {
            //Show Loader Dialog
            showLoaderDialogMessage(
              context,
              Theme.of(context).colorScheme.primary,
              MessageDialog.loadingMessage,
              true,
            );

            // //Logout, delete ticket
            // await UserPublicRepository.doLogout();

            if (kDebugMode) {
              print("Firebase logout & do logout successfully processed");
            }

            //Pop Loading
            if (context.mounted) {
              Navigator.of(context).pop();

              //Naivgate to splash
              if (context.mounted) {
                showConfirmDialog(
                    context,
                    HeaderDialog.successDialog("Log Out"),
                    MessageDialog.successLogOut,
                    ActionDialog.ok,
                    Theme.of(context)
                        .colorScheme
                        .primary, //ColorAccentOrange(),
                    functionOnOk: () async {
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                    CupertinoPageRoute(
                      builder: (context) => const SplashScreen(
                        splashTime: 1,
                        pageLoad: 0,
                        status: 'logout',
                      ),
                    ),
                  );
                });
              }
            }
          } on Exception catch (e, s) {
            if (kDebugMode) {
              print(
                  "Terjadi kegagalan saat log out (error : $e, stackTrace: $s)");
            }

            if (context.mounted) {
              if (isDialogShowing(context)) {
                Navigator.of(context).pop();
              }

              //Show confirm dialog
              showConfirmDialog(
                context,
                HeaderDialog.informasi,
                MessageDialog.failedAccess("logout google"),
                ActionDialog.ok,
                Theme.of(context).colorScheme.primary,
                functionOnOk: () =>
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                  CupertinoPageRoute(
                    builder: (context) => const SplashScreen(
                      splashTime: 1,
                      pageLoad: 0,
                      status: 'logout',
                    ),
                  ),
                ),
              );
            }
          }
        });
  }
}
