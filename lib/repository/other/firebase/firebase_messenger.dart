// import 'dart:async';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// class FirebaseMessenger {
//   //static FlutterSecureStorage fireStorage = new FlutterSecureStorage();
//   static String? deviceFireToken;
//
//   static getFireKey() {
//     return deviceFireToken;
//     //return await fireStorage.read(key: "firekey");
//   }
//
//   static fcmSubscribe(String topic) async {
//     await FirebaseMessaging.instance.subscribeToTopic(topic);
//
//     if (kDebugMode) {
//       print("Success Subscribing topic : $topic");
//     }
//   }
//
//   static fcmUnSubscribe(String topic) async {
//     await FirebaseMessaging.instance.unsubscribeFromTopic('all');
//
//     if (kDebugMode) {
//       print("Success Unsubscribing topic : $topic");
//     }
//   }
//
//   //Start Firebase Messaging
//   startFirebaseMessagingService() async {
//     await Firebase.initializeApp();
//
//     //Foreground Option
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // For testing purposes print the Firebase Messaging token
//     String? token = await FirebaseMessaging.instance.getToken();
//     //await fireStorage.write(key: "firekey", value: token);
//     deviceFireToken = token; //await getFireKey();
//     if (kDebugMode) {
//       print("Firebase Messaging Device Token: $deviceFireToken");
//     }
//   }
//
//   //Init Firebase Messaging for Controll
//   initFirebaseMessaging(
//       BuildContext context,
//       WidgetRef ref,
//       flutterLocalNotificationsPlugin,
//       AndroidNotificationChannel channel,
//       backgroundHandler) {
//     //On Message Status
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       // AppleNotification? apple = message.notification?.apple;
//
//       if (notification != null && android != null) {
//         if (kDebugMode) {
//           print(
//               'Message Title : ${message.notification!.title}, Message Body : ${message.notification!.body}');
//           print("Device Android, On Message Event! ${message.data}");
//           print("Data : ${message.data['data']}");
//         }
//
//         //@Flutter Local Notification
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               color: const Color(0xffe74c3c),
//               playSound: true,
//               icon: PushNotificationsManager.iconDrawable,
//               channelDescription: channel.description,
//             ),
//           ),
//           payload: message.data['do_action'],
//         );
//         // ======Action Status Notification On Message======
//
//         //======End Action For Notification======
//       }
//
//       // // If Notif on Apple
//       // else if(notification!= null && apple != null) {
//       //   flutterLocalNotificationsPlugin.show(
//       //     notification.hashCode,
//       //     notification.title,
//       //     notification.body,
//       //     const NotificationDetails(
//       //       iOS: IOSNotificationDetails()
//       //     )
//       //   );
//       // }
//     });
//
//     //On Message Open App
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       if (kDebugMode) {
//         print('Notifikasi Event Dibuka!!');
//       }
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         if (kDebugMode) {
//           print("Device Android, On Message Opened Event! ${message.data}");
//           print(
//               'Message Title : ${message.notification!.title}, Message Body : ${message.notification!.body}');
//         }
//
//         // //@Show Message Dialog Example
//         // showMessageDialog(
//         //   context,
//         //   notification.title!,
//         //   notification.body!,
//         //   message,
//         //   ref
//         // );
//
//         // ======Action Status Notification On Click Notification======
//         if (kDebugMode) {
//           print(
//               "Route User now : ${ModalRoute.of(context)?.settings.name ?? ''}");
//         }
//         //setelah berhasil absen rguler or setelah berhasil lupa absen
//         if (message.data['do_action'] == 'addmessage') {
//           if (kDebugMode) {
//             print("Get User -> absen rguler or setelah berhasil lupa absen");
//           }
//           //@Push to message page page if name modals not same
//           if ((ModalRoute.of(context)?.settings.name ?? '') !=
//               KonsultasiHukumChatPage.routeName) {
//             //@Push to absence history page
//             Navigator.of(context).pushNamed(
//               KonsultasiHukumChatPage.routeName,
//               arguments: KonsultasiHukumChatPageArguments(
//                 ticketId: message.data['data']['ticket_id'],
//                 userIdLogin: message.data['data']['user_id_login'],
//                 userIdPenerima: message.data['data']['user_id_penerima'],
//                 userRoleLogin: message.data['data']['user_role_login'],
//               ),
//             );
//           }
//           //@If Current Page == Absence History Page, Refresh only
//           else {
//             //@Refresh page
//             ref
//                 .read(konsultasiHukumChatPageViewModel.notifier)
//                 .refreshPage(ref);
//           }
//         }
//         // //notifikasi absen kegiatan or notifikasi lupa absen kegiatan
//         // else if (message.data['do_action'] == 'getAbsenPegawaiKegiatan') {
//         //   //@Push to absence base page if name modals not same
//         //   if ((ModalRoute.of(context)?.settings.name ?? '') !=
//         //       AbsenceHistoryPage.routeName) {
//         //     //@Push to absence history page
//         //     Navigator.of(context).pushNamed(
//         //       AbsenceHistoryPage.routeName,
//         //     );
//         //     //@Set filter to kegiatan
//         //     ref
//         //         .read(absenceHistoryPageViewModel.notifier)
//         //         .setAbsenceStatusFilter('kegiatan');
//         //     //@Refresh page
//         //     ref.read(absenceHistoryPageViewModel.notifier).refreshPage(ref);
//         //   }
//         //   //@If Current Page == Absence History Page, Refresh only
//         //   else {
//         //     //@Set filter to kegiatan
//         //     ref
//         //         .read(absenceHistoryPageViewModel.notifier)
//         //         .setAbsenceStatusFilter('kegiatan');
//         //     //@Refresh page
//         //     ref.read(absenceHistoryPageViewModel.notifier).refreshPage(ref);
//         //   }
//         // }
//         // //notifikasi yang mengajukan verifikasi bahwa ada update
//         // else if (message.data['do_action'] == 'getPermohonanVerifikasiAbsen') {
//         //   if ((ModalRoute.of(context)?.settings.name ?? '') !=
//         //       ForgotAbsenceRequestPage.routeName) {
//         //     //@Push to absence history page
//         //     Navigator.of(context).pushNamed(
//         //       AbsenceHistoryPage.routeName,
//         //     );
//         //   }
//         //   //@If Current Page == Absence Request Page, Refresh only
//         //   else {
//         //     //@Refresh page
//         //     ref.read(absenceHistoryPageViewModel.notifier).refreshPage(ref);
//         //   }
//         // }
//         // //notifikasi verifikator yang dipilih
//         // else if (message.data['do_action'] == 'getAbsenPegawaiVerifikator') {
//         //   if ((ModalRoute.of(context)?.settings.name ?? '') !=
//         //       ForgotAbsenceRequestPage.routeName) {
//         //     //@Push to absence history page
//         //     Navigator.of(context).pushNamed(
//         //       ForgotAbsenceRequestPage.routeName,
//         //     );
//         //   }
//         //   //@If Current Page == Absence Request Page, Refresh only
//         //   else {
//         //     //@Refresh page
//         //     ref
//         //         .read(forgotAbsenceRequestPageViewModel.notifier)
//         //         .refreshPage(ref);
//         //   }
//         // }
//         // //======End Action For Notification======
//       }
//     });
//
//     //On Message Get In Background
//     FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//   }
//
//   // //Confirmation Dialog Register on click
//   // showMessageDialog(BuildContext context, String title, String content, RemoteMessage message, WidgetRef ref) {
//   //   BuildContext? dialogContext;
//   //
//   //   // set up the buttons
//   //   Widget okButton = TextButton(
//   //     child: const Text("OK"),
//   //     onPressed:  () async {
//   //       //@close dialog
//   //       Navigator.pop(dialogContext!);
//   //     }
//   //   );
//   //
//   //   // set up the AlertDialog
//   //   AlertDialog alert = AlertDialog(
//   //     title: Text(title),
//   //     content: Text(content),
//   //     actions: [
//   //       okButton,
//   //     ],
//   //   ); // show the dialog
//   //   showDialog(
//   //     barrierDismissible: false,
//   //     context: context,
//   //     builder: (BuildContext dialog) {
//   //       dialogContext = dialog;
//   //
//   //       return alert;
//   //     },
//   //   );
//   // }
//
//   //@Background app action
//   static Future firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp();
//     if (kDebugMode) {
//       print('Background Message Baru Saja Tampil : ${message.data}');
//     }
//   }
// }
//
// // void _navigateToItemDetail(Map<String, dynamic> message) {
// //   final MessageBean item = _itemForMessage(message);
// //
// //   Navigator.popUntil(context, (route) => route.isFirst);
// //   //if
// // }
// //
// // class MessageBean {
// //   MessageBean({required this.itemId});
// //   final String itemId;
// //
// //   StreamController<MessageBean> _controller = StreamController<MessageBean>.broadcast();
// //   //Stream<MessageBean> get onChange;
// //
// //   final Map<String, MessageBean> _items = <String, MessageBean>{};
// // }
//
// // class NotificationsBloc {
// //   NotificationsBloc._internal();
// //
// //   static final NotificationsBloc instance = NotificationsBloc._internal();
// //
// //   final BehaviorSubject<LocalNotification> _notificationsStreamController = BehaviorSubject<LocalNotification>();
// //
// //   Stream<LocalNotification> get notificationsStream {
// //     return _notificationsStreamController;
// //   }
// //
// //   void newNotification(LocalNotification notification) {
// //     _notificationsStreamController.sink.add(notification);
// //   }
// //
// //   void dispose() {
// //     _notificationsStreamController?.close();
// //   }
// // }
