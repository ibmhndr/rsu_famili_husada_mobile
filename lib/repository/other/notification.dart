// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class PushNotificationsManager {
//   static const String icon = 'ic_stat_logo_jdihn_denpasar';
//   static const String iconDrawable = '@drawable/ic_stat_logo_jdihn_denpasar';
//
//   PushNotificationsManager._privateConstructor();
//   static final instance = PushNotificationsManager._privateConstructor();
//   factory PushNotificationsManager() {
//     return instance;
//   }
//
//   //Init Flutter Notification plugin Obj (Local)
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   //@Get Permission Before Usage
//   Future getPermission() async {
//     if (kDebugMode) {
//       print("Get permission first");
//     }
//
//     //Init For Android Obj
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings(icon);
//
//     //@Init For iOS Obj
//     DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//       notificationCategories: [
//         const DarwinNotificationCategory(
//           'demoCategory',
//           actions: <DarwinNotificationAction>[
//             // DarwinNotificationAction('id_1', 'Action 1'),
//             // DarwinNotificationAction(
//             //   'id_2',
//             //   'Action 2',
//             //   options: <DarwinNotificationActionOption>{
//             //     DarwinNotificationActionOption.destructive,
//             //   },
//             // ),
//             // DarwinNotificationAction(
//             //   'id_3',
//             //   'Action 3',
//             //   options: <DarwinNotificationActionOption>{
//             //     DarwinNotificationActionOption.foreground,
//             //   },
//             // ),
//           ],
//           options: <DarwinNotificationCategoryOption>{
//             DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
//           },
//         )
//       ],
//     );
//
//     //@Create Obj Initilization for both platform
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     //Registering Channel Plugin for Android
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(
//           NotificationChannel.instance.refreshChannel,
//         )
//         .then((value) {
//       if (kDebugMode) {
//         print(
//           "Success init android permission",
//         );
//       }
//     });
//
//     //Request Permission for iOS
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         )
//         .then((value) {
//       if (kDebugMode) {
//         print("Success init IOS permission : $value");
//       }
//     });
//
//     //Registering on click notification setting
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse:
//           (NotificationResponse notificationResponse) {
//         switch (notificationResponse.notificationResponseType) {
//           case NotificationResponseType.selectedNotification:
//             actionFromNotification(notificationResponse.payload);
//             break;
//           case NotificationResponseType.selectedNotificationAction:
//             //   if (notificationResponse.actionId == navigationActionId) {
//             //     actionFromNotification(notificationResponse.payload);
//             //   }
//             break;
//         }
//       },
//
//       //SHOUD BE USED ON TOP LEVEL FUNCTION USING notificationTapBackground method
//       //   onDidReceiveBackgroundNotificationResponse:
//       //         (NotificationResponse notificationResponse) {
//       //   switch (notificationResponse.notificationResponseType) {
//       //     case NotificationResponseType.selectedNotification:
//       //       actionFromNotification(notificationResponse.payload);
//       //       break;
//       //     case NotificationResponseType.selectedNotificationAction:
//       //       //   if (notificationResponse.actionId == navigationActionId) {
//       //       //     actionFromNotification(notificationResponse.payload);
//       //       //   }
//       //       break;
//       //   }
//       // }
//     ).then((value) {
//       if (kDebugMode) {
//         print("Success init message : $value");
//       }
//     });
//   }
//
//   @pragma('vm:entry-point')
//   void notificationTapBackground(NotificationResponse notificationResponse) {
//     // handle action
//   }
//
//   //@On Notification Get Tap Selected
//   Future actionFromNotification(String? payload) async {
//     if (payload != null) {
//       if (kDebugMode) {
//         print('notification payload data : $payload');
//       }
//
//       //setelah berhasil absen rguler or setelah berhasil lupa absen
//       // if (payload == 'addmessage') {
//       //   if (kDebugMode) {
//       //     print(
//       //         "Get Absen Pegawai -> absen rguler or setelah berhasil lupa absen");
//       //   }
//       //   //@Push to absence history page
//       //   mainNavigatorKey.currentState!.pushNamed(
//       //     AbsenceHistoryPage.routeName,
//       //   );
//       // }
//       // //notifikasi absen kegiatan or notifikasi lupa absen kegiatan
//       // else if (payload == 'getAbsenPegawaiKegiatan') {
//       //   //@Push to absence history page
//       //   mainNavigatorKey.currentState!.pushNamed(
//       //     AbsenceHistoryPage.routeName,
//       //   );
//       // }
//       // //notifikasi lupa absen diajukan
//       // else if (payload == 'getPermohonanVerifikasiAbsen') {
//       //   //@Push to absence history page
//       //   mainNavigatorKey.currentState!.pushNamed(
//       //     AbsenceHistoryPage.routeName,
//       //   );
//       // }
//       // //notifikasi verifikator yang dipilih
//       // else if (payload == 'getAbsenPegawaiVerifikator') {
//       //   //@Push to absence history page
//       //   mainNavigatorKey.currentState!.pushNamed(
//       //     ForgotAbsenceRequestPage.routeName,
//       //   );
//       // }
//     }
//     //@Payload Null
//     else {
//       if (kDebugMode) {
//         print('Payload Null');
//       }
//     }
//   }
//
//   //@On Receive notif iOS
//   void onDidReceiveLocalNotification(
//       int? id, String? title, String? body, String? payload) async {
//     // display a dialog with the notification details, tap ok to go to another page
//     // showDialog(
//     //   context: context,
//     //   builder: (BuildContext context) => CupertinoAlertDialog(
//     //     title: Text(title),
//     //     content: Text(body),
//     //     actions: [
//     //       CupertinoDialogAction(
//     //         isDefaultAction: true,
//     //         child: Text('Ok'),
//     //         onPressed: () async {
//     //           Navigator.of(context, rootNavigator: true).pop();
//     //           await Navigator.push(
//     //             context,
//     //             MaterialPageRoute(
//     //               builder: (context) => SecondScreen(payload),
//     //             ),
//     //           );
//     //         },
//     //       )
//     //     ],
//     //   ),
//     // );
//   }
//
//   //@Sample Notification
//   showNotification(int id, String title, String message, String payload) {
//     if (kDebugMode) {
//       print("Show Notification");
//     }
//
//     flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       message,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           NotificationChannel.instance.refreshChannel.id,
//           NotificationChannel.instance.refreshChannel.name,
//           channelDescription:
//               NotificationChannel.instance.refreshChannel.description,
//           importance: Importance.high,
//           color: const Color(0xffaa0000),
//           playSound: true,
//           icon: icon,
//         ),
//       ),
//       payload: payload,
//     );
//   }
// }
//
// //@Notification Channel for Android
// class NotificationChannel {
//   NotificationChannel._privateConstructor();
//   static final instance = NotificationChannel._privateConstructor();
//   factory NotificationChannel() {
//     return instance;
//   }
//
//   //Create Message Channel for refresh
//   AndroidNotificationChannel refreshChannel = const AndroidNotificationChannel(
//     'kanal_notifikasi_refresh', // id
//     'Kanal Notifikasi Refresh', // title
//     description: 'Notifikasi ini digunakan saat proses refresh', // description,
//     importance: Importance.low,
//     playSound: true,
//   );
//
//   //Create Message Channel for permohonan lupa absen
//   AndroidNotificationChannel permohonanLupaAbsenChannel =
//       const AndroidNotificationChannel(
//     'kanal_notifikasi_permohonan_lupa_absen', // id
//     'Kanal Notifikasi Permohonan Lupa Absen', // title
//     description:
//         'Notifikasi ini digunakan untuk pengajuan permohonan', // description,
//     importance: Importance.high,
//     playSound: true,
//   );
// }
