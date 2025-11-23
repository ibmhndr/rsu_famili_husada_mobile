import 'package:flutter/material.dart';
import 'package:rsufamilyhusadacare_mobile/model/departemen_response.dart';

class DefaultStateObj {
  DefaultStateObj._privateConstructor();
  static final instance = DefaultStateObj._privateConstructor();
  factory DefaultStateObj() {
    return instance;
  }

  //@Default State with data
  DateTime dateTimeDefault = DateTime(2000, 1, 1);
  TimeOfDay timeDefault = const TimeOfDay(hour: 00, minute: 00);

  DepartemenModel departemenDefault =
      const DepartemenModel(deptId: '', deptName: 'Pilih departemen');
}
