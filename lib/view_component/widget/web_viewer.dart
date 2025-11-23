// import 'dart:async';
//
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:html/parser.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewer extends StatefulWidget {
//   final String url;
//   final String? name;
//   final String? desc;
//   final bool isShowDesc;
//   final Function? onStart;
//   final Function? onProgress;
//   final Function? onFinished;
//   final LoadRequestMethod request;
//
//   const WebViewer(
//       {required this.url,
//       this.name,
//       this.desc,
//       this.isShowDesc = true,
//       this.onStart,
//       this.onProgress,
//       this.onFinished,
//       this.request = LoadRequestMethod.get,
//       Key? key})
//       : super(key: key);
//
//   @override
//   WebViewerState createState() => WebViewerState();
// }
//
// class WebViewerState extends State<WebViewer> {
//   late StreamController<int> _event;
//   late Timer _timer;
//   int _counter = 0;
//   double progress = 0;
//
//   late final WebViewController webViewController;
//
//   @override
//   void initState() {
//     super.initState();
//     _event = StreamController<int>();
//     _event.add(5);
//
//     //@Set webview controller
//     webViewController = WebViewController()
//       ..loadRequest(
//         Uri.parse(widget.url),
//         method: widget.request,
//         body: Uint8List.fromList('tiket=${SplashScreenState.tiket}'.codeUnits),
//       )
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(NavigationDelegate(
//         onProgress: (progress) {
//           if (kDebugMode) {
//             print("Data Progress : $progress");
//           }
//
//           //Set progress for loading
//           setState(() {
//             this.progress = progress / 100;
//           });
//
//           //@If Function on progress is not empty
//           if (widget.onStart != null) {
//             widget.onStart;
//           }
//           // showLoaderDialogMessage(context, loaderColor, message, rootNavigator)
//         },
//         onPageStarted: (String url) async {
//           if (kDebugMode) {
//             print('Page started loading: $url');
//           }
//           _startTimer(context);
//
//           if (widget.isShowDesc) {
//             final desc = parse(widget.desc ?? '');
//             showWebviewDialog(
//                 context,
//                 HeaderDialog.informasi,
//                 ((desc.documentElement?.text ?? '').isNotEmpty)
//                     ? desc.documentElement?.text ?? 'Deskripsi'
//                     : 'Deskripsi',
//                 Theme.of(context).colorScheme.primary);
//           }
//         },
//         onPageFinished: (String url) {
//           if (kDebugMode) {
//             print('Page finished loading: $url');
//           }
//         },
//         onNavigationRequest: (request) {
//           return NavigationDecision.navigate;
//
//           // if (request.url.startsWith(NetworkSettings.hosts)) {
//           //   if (kDebugMode) {
//           //     print('allowing navigation to ${request.url}');
//           //   }
//           //   return NavigationDecision.navigate;
//           // }
//           //
//           // if (kDebugMode) {
//           //   print('blocking navigation to ${request.url}');
//           // }
//           // return NavigationDecision.prevent;
//         },
//         onWebResourceError: (error) => print("Web resource error : $error"),
//       ));
//
//     // // // Enable virtual display.
//     // if (webViewController.platform is AndroidWebViewController) {
//     //   AndroidWebViewController.enableDebugging(true);
//     //   (webViewController.platform as AndroidWebViewController)
//     //       .setMediaPlaybackRequiresUserGesture(false);
//     // }
//   }
//
//   //@Check if any route showing beside this page
//   _isThereCurrentDialogShowing(BuildContext context) =>
//       ModalRoute.of(context)?.isCurrent != true;
//
//   void _startTimer(BuildContext context) {
//     const oneSec = Duration(seconds: 1);
//     _counter = 5;
//
//     _timer = Timer.periodic(oneSec, (Timer timer) {
//       if (kDebugMode) {
//         print("Time : $_event");
//       }
//
//       if (_counter == 0) {
//         if (kDebugMode) {
//           print("Timer Cancel");
//         }
//         timer.cancel();
//
//         //@if currently there are any dialog open
//         if (_isThereCurrentDialogShowing(context)) {
//           Navigator.of(context).pop();
//         }
//       } else {
//         _counter--;
//       }
//
//       _event.add(_counter);
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         iconTheme: IconThemeData(color: colorBlack()),
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         actions: [
//           IconButton(
//               onPressed: () => webViewController.reload(),
//               icon: const Icon(Icons.refresh))
//         ],
//         elevation: 1,
//         title: AutoSizeText(
//           (widget.name != null) ? widget.name! : widget.url,
//           maxLines: 1,
//           minFontSize: 14,
//           maxFontSize: 18,
//         ),
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: webViewController),
//           progress < 1.0
//               ? LinearProgressIndicator(
//                   value: progress, color: Theme.of(context).colorScheme.primary)
//               : Container(),
//         ],
//       ),
//     );
//   }
//
//   void showWebviewDialog(
//       BuildContext context, String title, String content, Color colors,
//       {Function? functionOnOk}) {
//     BuildContext? dialogContext; // set up the button
//     Widget okButton = TextButton(
//       child: StreamBuilder<int>(
//         stream: _event.stream,
//         builder: (context, snapshot) =>
//             Text("Tutup (${snapshot.data})", style: TextStyle(color: colors)),
//       ),
//       onPressed: () {
//         Navigator.pop(dialogContext!);
//         if (functionOnOk != null) {
//           functionOnOk();
//         }
//       },
//     ); // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(title),
//       content: Text(content),
//       actions: [
//         okButton,
//       ],
//     );
//
//     // show the dialog
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialog) {
//         dialogContext = dialog;
//         return alert;
//       },
//     );
//   }
// }
