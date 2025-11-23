import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navigation_utils/navigation_utils.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rsufamilyhusadacare_mobile/routes/navigation_routes.dart';
import 'package:rsufamilyhusadacare_mobile/settings/network_settings.dart';
import 'package:rsufamilyhusadacare_mobile/view/splash_screen/splash_screen.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/global/global_var.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/view_component.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  //@Init Time Zone
  tz.initializeTimeZones();

  //Widget Binding
  WidgetsFlutterBinding.ensureInitialized();

  //Set Potrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //@Init network settings
  NetworkSettings.initNetworkSetting();

  // //Get Permission for Local Notification
  // await pushNotificationsManager.getPermission();

  // //@Init Firebase App Dependency
  // try {
  //   await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //       apiKey: App.instance.googleApiKey,
  //       appId: App.instance.googleFirebaseAppId,
  //       messagingSenderId: App.instance.googleFirebaseMessageSenderId,
  //       projectId: App.instance.googleFirebaseProjectId,
  //     ),
  //   );
  //   //@INIT CRASHLYTICS
  //   FlutterError.onError = (errorDetails) {
  //     FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  //   };
  //   //Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  //   PlatformDispatcher.instance.onError = (error, stack) {
  //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //     return true;
  //   };
  // } on Exception catch (e, stackTrace) {
  //   if (kDebugMode) {
  //     print(
  //       "Terjadi kegagalan inisialisasi firebase : (Error : $e, StackTrace : $stackTrace)",
  //     );
  //   }
  // }
  //
  // //Start Firebase Service Messaging
  // try {
  //   firebaseMessageNotification.startFirebaseMessagingService();
  //   //Get Permission for Local Notification
  //   await pushNotificationsManager.getPermission();
  // } on Exception catch (e, stackTrace) {
  //   if (kDebugMode) {
  //     print(
  //       "Terjadi kegagalan memperoleh izin notifikasi : (Error $e, stackTrace : $stackTrace)",
  //     );
  //   }
  // }

  //End setting
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      settings: PlatformSettingsData(
        iosUsesMaterialWidgets: true,
      ),
      builder: (BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'D-Health Signature',
        navigatorKey: mainNavigatorKey,
        // localizationsDelegates: const [
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   MonthYearPickerLocalizations.delegate, //Lib for month year picker
        // ],
        theme: MyTheme.lightTheme(context),
        // darkTheme: MyTheme.darkTheme(context),
        themeMode: ThemeMode.light,
        builder: (context, child) => ResponsiveBreakpoints(
          breakpoints: const [
            Breakpoint(start: 0, end: 450, name: MOBILE),
            Breakpoint(start: 451, end: 834, name: TABLET),
            Breakpoint(start: 835, end: 1920, name: DESKTOP),
            // Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
          breakpointsLandscape: const [
            Breakpoint(start: 0, end: 812, name: MOBILE),
            Breakpoint(start: 813, end: 1112, name: TABLET),
            Breakpoint(start: 1113, end: double.infinity, name: DESKTOP),
            // Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
          child: child!,
        ),
        home: const SplashScreen(
          splashTime: 3,
          pageLoad: 0,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return Routes.fadeThrough(
            settings,
            (context) => ConditionalRouteWidget(
              builder: (context, child) => MaxWidthBox(
                maxWidth: 1920,
                child: ResponsiveScaledBox(
                  // ResponsiveScaledBox renders its child with a FittedBox set to the `width` value.
                  // Set the fixed width value based on the active breakpoint.
                  width: (ResponsiveBreakpoints.of(context).orientation ==
                          Orientation.portrait)
                      //@Potrait
                      ? ResponsiveValue<double>(
                          context,
                          conditionalValues: [
                            const Condition.equals(name: MOBILE, value: 450),
                            const Condition.equals(name: TABLET, value: 600),
                            const Condition.equals(name: DESKTOP, value: 1000),
                            // There are no conditions for width over 1200
                            // because the `maxWidth` is set to 1200 via the MaxWidthBox.
                          ],
                        ).value
                      //Landscape
                      : ResponsiveValue<double>(
                          context,
                          conditionalValues: [
                            const Condition.equals(name: MOBILE, value: 812),
                            const Condition.equals(name: TABLET, value: 1000),
                            const Condition.equals(name: DESKTOP, value: 1600),
                            // There are no conditions for width over 1200
                            // because the `maxWidth` is set to 1200 via the MaxWidthBox.
                          ],
                        ).value,
                  child: child!,
                ),
              ),
              child: BouncingScrollWrapper.builder(
                context,
                Routes.buildPage(settings),
                dragWithMouse: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
