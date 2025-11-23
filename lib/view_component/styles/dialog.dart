import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//======DIALOG======
//Set Confirm Dialog
void showConfirmDialog(BuildContext context, String title, String content,
    String confirmText, Color colors,
    {Function? functionOnOk}) {
  //Login Dialog
  showConfirmDialog(BuildContext context) {
    BuildContext? dialogContext; // set up the button
    Widget okButton = TextButton(
      child: Text(confirmText, style: TextStyle(color: colors)),
      onPressed: () {
        Navigator.pop(dialogContext!);
        if (functionOnOk != null) {
          functionOnOk();
        }
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialog) {
        dialogContext = dialog;
        return alert;
      },
    );
  }

  //Show Sign In Result Dialog
  showConfirmDialog(context);
}

//Alert Dialog Registration Error
showMultipleChoiceDialog(
    {required BuildContext context,
    required String title,
    required String content,
    required String cancelText,
    required String confirmText,
    required Color colorsCancel,
    required Color colorsConfirm,
    required bool isConfirmPrimarySelected,
    required Color backgroundPrimaryColor,
    required bool useRoot,
    Function? functionOnCancel,
    Function? functionOnConfirm,
    String deleteDialogCancelStatus = 'end',
    String deleteDialogConfirmStatus = 'end'}) {
  BuildContext? dialogContext;
  // set up the buttons
  Widget cancelButton = (isConfirmPrimarySelected == false)
      ? DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundPrimaryColor,
          ),
          child: TextButton(
            child: Text(cancelText,
                style: TextStyle(
                    color: colorsCancel, overflow: TextOverflow.ellipsis)),
            onPressed: () {
              //@If Delete dialog on start
              if (deleteDialogCancelStatus == 'start') {
                Navigator.pop(dialogContext!);
              }

              if (functionOnCancel != null) {
                functionOnCancel() ?? () {};
              }

              //@If Delete dialog on end
              if (deleteDialogCancelStatus == 'end') {
                Navigator.pop(dialogContext!);
              }
            },
          ),
        )
      : TextButton(
          child: Text(cancelText,
              style: TextStyle(
                  color: colorsCancel, overflow: TextOverflow.ellipsis)),
          onPressed: () {
            //@If Delete dialog on start
            if (deleteDialogCancelStatus == 'start') {
              Navigator.pop(dialogContext!);
            }

            if (functionOnCancel != null) {
              functionOnCancel() ?? () {};
            }

            //@If Delete dialog on end
            if (deleteDialogCancelStatus == 'end') {
              Navigator.pop(dialogContext!);
            }
          },
        );
  Widget continueButton = (isConfirmPrimarySelected == false)
      ? TextButton(
          child: Text(confirmText,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colorsConfirm)),
          onPressed: () async {
            //@If Delete dialog on start
            if (deleteDialogConfirmStatus == 'start') {
              Navigator.pop(dialogContext!);
            }

            if (functionOnConfirm != null) {
              functionOnConfirm() ?? () {};
            }

            //@If Delete dialog on end
            if (deleteDialogConfirmStatus == 'end') {
              Navigator.pop(dialogContext!);
            }
          },
        )
      : DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundPrimaryColor,
          ),
          child: TextButton(
            child: Text(confirmText,
                style: TextStyle(
                    color: colorsConfirm, overflow: TextOverflow.ellipsis)),
            onPressed: () async {
              //@If Delete dialog on start
              if (deleteDialogConfirmStatus == 'start') {
                Navigator.pop(dialogContext!);
              }

              if (functionOnConfirm != null) {
                functionOnConfirm() ?? () {};
              }

              //@If Delete dialog on end
              if (deleteDialogConfirmStatus == 'end') {
                Navigator.pop(dialogContext!);
              }
            },
          ),
        );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      cancelButton,
      continueButton,
    ],
  ); // show the dialog
  showDialog(
    barrierDismissible: false,
    useRootNavigator: useRoot,
    context: context,
    builder: (BuildContext dialog) {
      dialogContext = dialog;
      return alert;
    },
  );
}

//Show Loader Dialog
void showLoaderDialog(
    BuildContext context, Color loaderColor, bool rootNavigator,
    {double radius = 8, Color backgroundColor = Colors.white, Function? func}) {
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    backgroundColor: Colors.white.withOpacity(1),
    content: SizedBox(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.01,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: SpinKitThreeBounce(
              size: 30,
              color: loaderColor,
            ),
          ),
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    useRootNavigator: rootNavigator,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ).then(
    (value) => (func != null) ? func() : null,
  );
}

//Show Loader Dialog With Message
void showLoaderDialogMessage(
    BuildContext context, Color loaderColor, String message, bool rootNavigator,
    {double radius = 8, Color backgroundColor = Colors.white, Function? func}) {
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
    backgroundColor: backgroundColor,
    content: SizedBox(
      height: MediaQuery.of(context).size.width * 0.2,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: SpinKitThreeBounce(
              size: 30,
              color: loaderColor,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Flexible(
            child: AutoSizeText(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    useRootNavigator: rootNavigator,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ).then((value) => (func != null) ? func() : null);
}

//Show Triple Choice Dialog
showTripleChoiceDialog(BuildContext context, String title, String content,
    String firstText, String secondText, String thirdText, Color colors,
    {Function? functionOnFirst,
    Function? functionOnSecond,
    Function? functionOnThird}) {
  BuildContext? dialogContext;
  // set up the buttons
  Widget firstButton = TextButton(
    child: Text(
      firstText,
      style: TextStyle(color: colors),
    ),
    onPressed: () {
      if (functionOnFirst != null) {
        functionOnFirst() ?? () {};
      }
      Navigator.pop(dialogContext!);
    },
  );
  Widget secondButton = TextButton(
    child: Text(
      secondText,
      style: TextStyle(color: colors),
    ),
    onPressed: () async {
      if (functionOnSecond != null) {
        functionOnSecond() ?? () {};
      }
      Navigator.pop(dialogContext!);
    },
  );
  Widget thirdButton = TextButton(
    child: Text(
      thirdText,
      style: TextStyle(color: colors),
    ),
    onPressed: () async {
      Navigator.pop(dialogContext!);
      if (functionOnThird != null) {
        functionOnThird() ?? () {};
      }
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      firstButton,
      secondButton,
      thirdButton,
    ],
  ); // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialog) {
      dialogContext = dialog;
      return alert;
    },
  );
}
