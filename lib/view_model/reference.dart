import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rsufamilyhusadacare_mobile/model/antrean_response.dart';
import 'package:rsufamilyhusadacare_mobile/model/departemen_response.dart';
import 'package:rsufamilyhusadacare_mobile/repository/api/antrean_repository.dart';
import 'package:rsufamilyhusadacare_mobile/repository/api/departemen_repository.dart';
import 'package:rsufamilyhusadacare_mobile/repository/other/network_checker.dart';
import 'package:rsufamilyhusadacare_mobile/view_model/home_page/home_page_event.dart';
import 'package:rsufamilyhusadacare_mobile/view_model/home_page/home_page_state.dart';
import 'package:rsufamilyhusadacare_mobile/view_model/splash_screen/splash_screen_event.dart';
import 'package:rsufamilyhusadacare_mobile/view_model/splash_screen/splash_screen_state.dart';

//Provider View Model
//======CHECK CONNECTION======
final networkAwareProvider = StateNotifierProvider((_) {
  return NetworkDetectorNotifier();
});

//======Not Auto Dispose Value======
// final StateNotifierProvider<BottomNavigationEvent, BottomNavigationState>
//     bottomNavigationViewModel =
//     StateNotifierProvider((_) => BottomNavigationEvent());

final StateNotifierProvider<SplashScreenEvent, SplashScreenState>
    splashScreenViewModel = StateNotifierProvider((_) => SplashScreenEvent());

//======LOGIN & PROFILE======
// final AutoDisposeStateNotifierProvider<RegisterPageEvent, RegisterPageState>
//     registerPageViewModel =
//     StateNotifierProvider.autoDispose((_) => RegisterPageEvent());

// final AutoDisposeStateNotifierProvider<LoginPageEvent, LoginPageState>
//     loginPageViewModel = StateNotifierProvider.autoDispose(
//   (_) => LoginPageEvent(),
// );

// //@Device Name
// final AutoDisposeFutureProvider<String?> deviceNameFutureViewModel =
//     AutoDisposeFutureProvider<String?>((ref) {
//   return UserRepository.instance.getDeviceName();
// });

final AutoDisposeStateNotifierProvider<HomePageEvent, HomePageState>
    homePageViewModel = StateNotifierProvider.autoDispose(
  (_) => HomePageEvent(),
);

// final AutoDisposeStateNotifierProvider<PerkaraPageEvent, PerkaraPageState>
//     perkaraPageViewModel = StateNotifierProvider.autoDispose(
//   (_) => PerkaraPageEvent(),
// );

// //======Future Provider======
//Antrean Response
final AutoDisposeFutureProviderFamily<AntreanResponse, Map<String, dynamic>>
    antreanViewModel =
    AutoDisposeFutureProviderFamily<AntreanResponse, Map<String, dynamic>>(
        (ref, args) {
  // An object from package:dio that allows cancelling http requests
  final cancelToken = CancelToken();
  // When the provider is destroyed, cancel the http request
  ref.onDispose(
    () {
      if (kDebugMode) {
        print("Cancel Token Antrean");
      }

      cancelToken.cancel();
    },
  );

  // Fetch our data and pass our `cancelToken` for cancellation to work
  final response = AntreanRepository.instance.postData(
    args,
    token: cancelToken,
  );

  return response;
});

//Departemen Response
final AutoDisposeFutureProvider<DepartemenResponse> departemenViewModel =
    AutoDisposeFutureProvider<DepartemenResponse>((ref) {
  // An object from package:dio that allows cancelling http requests
  final cancelToken = CancelToken();
  // When the provider is destroyed, cancel the http request
  ref.onDispose(
    () {
      if (kDebugMode) {
        print("Cancel Token Departemen");
      }

      cancelToken.cancel();
    },
  );

  // Fetch our data and pass our `cancelToken` for cancellation to work
  final response = DepartemenRepository.instance.postData(
    {},
    token: cancelToken,
  );

  return response;
});

// //@Stream Data Tagihan Detail
// final AutoDisposeStreamProviderFamily<TagihanDetailResponse,
//     Map<String, dynamic>> tagihanDetailStreamViewModel =
// AutoDisposeStreamProviderFamily<TagihanDetailResponse,
//     Map<String, dynamic>>((ref, args) async* {
//   bool isStart = true;
//   String tId = args['t_id'];
//
//   while (true) {
//     // if (kDebugMode) {
//     //   print(
//     //       "Tagihan Detail Time Now ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}");
//     // }
//
//     //@Stream start give default value
//     if (isStart) {
//       isStart = false;
//
//       yield await TagihanDetailRepository.instance.getData(args);
//     }
//     //@Delay Stream Every 3 Seconds
//     else {
//       await Future.delayed(
//         const Duration(seconds: 2),
//       );
//
//       if (tId != args['t_id']) {
//         //set t_id
//         tId = args['t_id'];
//
//         //Yield data
//         yield await TagihanDetailRepository.instance.getData(args);
//       }
//     }
//   }
// });
