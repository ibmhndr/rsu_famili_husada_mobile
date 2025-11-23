import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:rsufamilyhusadacare_mobile/repository/other/connection_checker.dart';
import 'package:rsufamilyhusadacare_mobile/routes/navigation_routes.dart';
import 'package:rsufamilyhusadacare_mobile/view/home_page.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/styles/toast.dart';
import 'package:rsufamilyhusadacare_mobile/view_model/splash_screen/splash_screen_state.dart';

class SplashScreenEvent extends StateNotifier<SplashScreenState> {
  SplashScreenEvent()
      : super(SplashScreenState(
          isLogin: false,
        ));

  //===========METHOD=================
  //@Responsive Apps
  void initDevice(context, String? recentSplashStatus) {
    SplashScreenState.deviceSetting = MediaQuery.of(context);
    SplashScreenState.status = recentSplashStatus ?? 'normal';
  }

  // //@Check Status User
  Future<void> initCheckStatusUser() async {
    try {
      if (kDebugMode) {
        print('======INIT APPS CHECK STATUS USER======');
      }

      // // //@get login value
      // bool login = await UserRepository.checkLogin();

      if (kDebugMode) {
        // print('Status Login Init Check Status : $login');
      }

      // //@State save is login
      // state = state.copyWith(
      //   isLogin: state.isLogin = login,
      // );

      //@If login true set tiket
      if (state.isLogin == true) {
        // SplashScreenState.tiket = await UserRepository.getLoginData();
        if (kDebugMode) {
          print('Tiket : ${SplashScreenState.tiket}');
        }
      }
      //@Else Tiket kosong
      else {
        SplashScreenState.tiket = '';
        if (kDebugMode) {
          print('Tiket : ${SplashScreenState.tiket}');
        }
      }
    } on Exception catch (exception, stackTrace) {
      // await captureError(exception, stackTrace);

      if (kDebugMode) {
        print(
            "Terjadi kegagalan mengakses data pengguna : $exception, $stackTrace");
      }
      showToast("Terjadi kegagalan mengakses data pengguna lokal");
    }
  }

  // Init Home Requirement
  Future<Map<String, dynamic>> initHomeRequirement(WidgetRef ref) async {
    try {
      Stopwatch timeloadStatus = Stopwatch()..start();

      //@Check connection
      ConnectionStatus connectionStatus =
          await Connection.instance.checkConnection();

      // //@Set profile data to local
      if (connectionStatus == ConnectionStatus.internetAvailable) {
        // final ProfileResponse profileResponse =
        //     await UserProfileRepository.instance.postData({});

        //Stop TimeLoad
        timeloadStatus.stop();
        int timeLoad = 0;

        //Check Time Load if > 3. Set for minimum remaining load time
        timeLoad = timeloadStatus.elapsed.inSeconds;

        if (kDebugMode) {
          print('Waktu Load Status : ${timeloadStatus.elapsed.inSeconds}');
        }

        return {
          // 'profile_data': (profileResponse.result.isNotEmpty)
          //     ? profileResponse
          //     : ProfileResponse(
          //         result: const [],
          //         status: 'error',
          //         message: '',
          //       ),
          'timeload': timeLoad.toString(),
        };
      } else {
        showToast(
          "Gagal mengakses internet, mohon cek ketersediaan internet anda",
        );

        return {
          // 'profile_data': ProfileResponse(
          //   result: const [],
          //   status: 'error',
          //   message: '',
          // ),
          'timeload': '0',
        };
      }
    } on Exception catch (exception, stackTrace) {
      // await logErrorCrashlytics(exception, stackTrace);

      if (kDebugMode) {
        print(
          "Terjadi kegagalan mengakses data pengguna : (error: $exception, stackTrace: $stackTrace)",
        );
      }

      return {
        // 'profile_data': ProfileResponse(
        //   result: const [],
        //   status: 'error',
        //   message: '',
        // ),
        'timeload': '0',
      };
    }
  }

  //@Init Splash
  initSplash(
      int splashTime, int pageLoad, BuildContext context, WidgetRef ref) async {
    try {
      await mainProcess(ref, splashTime, context);

      if (kDebugMode) {
        print("Debug No Update Check");
      } else {
        //@Check for update then if available execute update according to status
        final AppUpdateInfo appUpdateStatus =
            await InAppUpdate.checkForUpdate();

        if (kDebugMode) {
          print("App Update Status : ${appUpdateStatus.updateAvailability}");
        }

        //@If Update Available Then Update
        if (appUpdateStatus.updateAvailability ==
                UpdateAvailability.updateAvailable &&
            context.mounted) {
          await doMinorUpdate(ref, splashTime, context);
        }
      }
    } on Exception catch (exception) {
      // await captureError(exception, stackTrace);

      if (kDebugMode) {
        print("Error Update : $exception");
      }
    }
  }

  Future<void> doMinorUpdate(
      WidgetRef ref, int splashTime, BuildContext context) async {
    final AppUpdateResult appUpdateResult =
        await InAppUpdate.startFlexibleUpdate();

    //@If Success
    if (appUpdateResult == AppUpdateResult.success) {
      //@Complete flexible update
      InAppUpdate.completeFlexibleUpdate().then((_) {
        showToast("Update berhasil");
      });
    } else if (appUpdateResult == AppUpdateResult.inAppUpdateFailed) {
      showToast(
          "Terjadi kegagalan saat update aplikasi, mohon coba kembali dalam beberapa saat");
    }
  }

  Future<void> doMajorUpdate() async {
    final AppUpdateResult appUpdateResult =
        await InAppUpdate.performImmediateUpdate();

    //@If Success
    if (appUpdateResult == AppUpdateResult.success) {
      //@Complete update
      showToast(
        "Update berhasil",
      );
    } else if (appUpdateResult == AppUpdateResult.inAppUpdateFailed) {
      showToast(
        "Terjadi kegagalan saat update aplikasi, mohon coba kembali dalam beberapa saat",
      );
    }
  }

  Future mainProcess(
    WidgetRef ref,
    int splashTime,
    BuildContext context,
  ) async {
    try {
      //@Check Status User First
      await initCheckStatusUser();

      //@Init Home Requirement
      Map<String, dynamic> dataLogin = await initHomeRequirement(ref);
      // final ProfileResponse profileRepository = dataLogin['profile_data'];

      // if (profileRepository.status == 'success' &&
      //     (profileRepository.result).isNotEmpty) {
      //   Timer(
      //     Duration(seconds: splashTime - int.parse(dataLogin['timeload'])),
      //     () => Navigator.of(context).pushReplacementNamed(
      //       HomePage.routeName,
      //       arguments: HomePageArguments(
      //         device: device,
      //         profile: profileRepository.result.first,
      //       ),
      //     ),
      //   );
      // }
      // //@Navigate to Splash Screen if not login
      // else {
      //   Timer(
      //     Duration(seconds: splashTime),
      //     () => Navigator.of(context).pushReplacementNamed(
      //       LoginPage.routeName,
      //       arguments: LoginPageArguments(),
      //     ),
      //   );
      // }

      Timer(
        Duration(seconds: splashTime),
        () => Navigator.of(context).pushReplacementNamed(
          HomePage.routeName,
          arguments: HomePageArguments(),
        ),
      );
    } on Exception catch (exception) {
      // await captureError(exception, stackTrace);

      if (kDebugMode) {
        print("Terjadi kegagalan memperoleh data aplikasi: $exception");
      }
      showToast(
          "Terjadi kegagalan memperoleh data aplikasi, mohon ulangi kembali membuka aplikasi");
    }
  }

  //@Read android build data
  // Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  //   return <String, dynamic>{
  //     'version.securityPatch': build.version.securityPatch,
  //     'version.sdkInt': build.version.sdkInt,
  //     'version.release': build.version.release,
  //     'version.previewSdkInt': build.version.previewSdkInt,
  //     'version.incremental': build.version.incremental,
  //     'version.codename': build.version.codename,
  //     'version.baseOS': build.version.baseOS,
  //     'board': build.board,
  //     'bootloader': build.bootloader,
  //     'brand': build.brand,
  //     'device': build.device,
  //     'display': build.display,
  //     'fingerprint': build.fingerprint,
  //     'hardware': build.hardware,
  //     'host': build.host,
  //     'id': build.id,
  //     'manufacturer': build.manufacturer,
  //     'model': build.model,
  //     'product': build.product,
  //     'supported32BitAbis': build.supported32BitAbis,
  //     'supported64BitAbis': build.supported64BitAbis,
  //     'supportedAbis': build.supportedAbis,
  //     'tags': build.tags,
  //     'type': build.type,
  //     'isPhysicalDevice': build.isPhysicalDevice,
  //     'systemFeatures': build.systemFeatures,
  //   };
  // }
}
