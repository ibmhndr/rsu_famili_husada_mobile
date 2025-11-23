import 'package:flutter/material.dart';
import 'package:timezone/standalone.dart' as tz;

//@Main Navigator key
final GlobalKey<NavigatorState> mainNavigatorKey =
    GlobalKey(debugLabel: "Main Navigator"); //

class App {
  //Singleton
  App._privateConstructor();
  static final App instance = App._privateConstructor();
  factory App() {
    return instance;
  }

  final googleApiKey = 'AIzaSyBQfC9OCQMu9UVbD7l9XUrUGjQERhkyNcY';
  final googleFirebaseProjectId = 'jdih-denpasar-94db9';
  final googleFirebaseAppId = '1:354619677191:android:53f4c744eb3b33c456e8a2';
  final googleFirebaseMessageSenderId = '354619677191';

  tz.TZDateTime getTimeZone() {
    tz.Location location = tz.getLocation('Asia/Singapore');
    return tz.TZDateTime.now(location);
  }
}
