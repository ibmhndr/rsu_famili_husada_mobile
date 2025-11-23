// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:jdih_kota_denpasar/view_component/view_component.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class YoutubeViewer extends HookConsumerWidget {
//   final YoutubePlayerController controller;
//
//   const YoutubeViewer({
//     super.key,
//     required this.controller,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final youtubeController = useState(controller);
//
//     useEffect(() {
//       //Set Landscape
//       SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
//       controller.reload();
//
//       return null;
//     }, []);
//
//     return WillPopScope(
//       onWillPop: () async {
//         //Set Potrait only
//         SystemChrome.setPreferredOrientations(
//           [
//             DeviceOrientation.portraitUp,
//             DeviceOrientation.portraitDown,
//           ],
//         );
//
//         return true;
//       },
//       child: YoutubePlayerBuilder(
//         player: YoutubePlayer(
//           controller: controller,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Theme.of(context).colorScheme.secondary,
//           progressColors: ProgressBarColors(
//             playedColor: Theme.of(context).colorScheme.secondary,
//             handleColor: Theme.of(context).colorScheme.secondary,
//           ),
//           onReady: () {
//             // youtubeController
//             //     .addListener(
//             //         listener);
//           },
//           bottomActions: [
//             CurrentPosition(),
//             ProgressBar(
//               isExpanded: true,
//             ),
//             // PlayPauseButton(),
//             const PlaybackSpeedButton(),
//             RemainingDuration(),
//             IconButton(
//               padding: const EdgeInsets.only(
//                 left: 4,
//               ),
//               constraints: const BoxConstraints(),
//               onPressed: () {
//                 //Set Potrait only
//                 SystemChrome.setPreferredOrientations(
//                   [
//                     DeviceOrientation.portraitUp,
//                     DeviceOrientation.portraitDown,
//                   ],
//                 );
//
//                 //Pop
//                 Navigator.of(context).pop();
//               },
//               icon: Icon(
//                 Icons.fullscreen,
//                 color: colorWhite(),
//               ),
//             ),
//             // FullScreenButton(),
//           ],
//         ),
//         builder: (context, player) {
//           return Column(
//             children: [
//               // some widgets
//               player,
//               //some other widgets
//             ],
//           );
//         },
//         onEnterFullScreen: () {},
//         onExitFullScreen: () {},
//       ),
//     );
//   }
// }
