import 'package:flutter/material.dart';

isDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;
