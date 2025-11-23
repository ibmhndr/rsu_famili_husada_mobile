import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:rsufamilyhusadacare_mobile/view/home_page.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/pages/error_not_found_page.dart';

//======ROUTE CLASS======
class Routes {
  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(
          animation: animation,
          child: child,
        );
      },
    );
  }

  // static Route navigationRoutes(RouteSettings settings) {
  //   final args = settings.arguments;
  //   switch (settings.name) {
  //     //On Splash Screen
  //     case SplashScreen.routeName:
  //       final value = args as SplashScreenArguments;
  //       SplashScreenArguments data = value;
  //       return CupertinoPageRoute(
  //         settings: settings,
  //         builder: (context) => SplashScreen(
  //             splashTime: data.splashTime, pageLoad: data.pageLoad),
  //       );
  //
  //     //On Splash Screen
  //     case HomePage.routeName:
  //       // final value = args as LoginPageArguments;
  //       // LoginPageArguments data = value;
  //       return CupertinoPageRoute(
  //         settings: settings,
  //         builder: (context) => const HomePage(),
  //       );
  //
  //     //@Input Data Page Route
  //     // case IntroductionScreenPage.routeName:
  //     //   return CupertinoPageRoute(
  //     //       settings: settings, builder: (context) => IntroductionScreenPage());
  //     //
  //     // //@Input Data Page Route
  //     // case LogInPage.routeName:
  //     //   return CupertinoPageRoute(
  //     //       settings: settings, builder: (context) => const LogInPage());
  //
  //     // //@Bottom Navigation Page
  //     // case BottomNavigation.routeName:
  //     //   final data = args as BottomNavigationArguments;
  //     //   return CupertinoPageRoute(
  //     //     settings: settings,
  //     //     builder: (context) => BottomNavigation(
  //     //       pageLoad: data.pageLoad,
  //     //       profileData: data.profileData,
  //     //     )
  //     //   );
  //     //
  //     // case BottomNavigation.routeName:
  //     //   final data = args as BottomNavigationArguments;
  //     //   return CupertinoPageRoute(
  //     //       settings: settings,
  //     //       builder: (context) => BottomNavigation(
  //     //             pageLoad: data.pageLoad,
  //     //             profileData: data.profileData,
  //     //           ));
  //     //
  //     // //@Home
  //     // case HomePage.routeName:
  //     //   final data = args as HomePageArguments;
  //     //   return CupertinoPageRoute(
  //     //       settings: settings,
  //     //       builder: (context) => HomePage(
  //     //             profileData: data.profileData,
  //     //           ));
  //     //
  //     // //@Profile Page
  //     // case ProfilePage.routeName:
  //     //   final data = args as ProfilePageArguments;
  //     //   return CupertinoPageRoute(
  //     //       settings: settings,
  //     //       builder: (context) => ProfilePage(
  //     //             profileData: data.profileData,
  //     //           ));
  //
  //     default:
  //       return _errorRoute();
  //   }
  // }

  //@Error Route

  // static Route<dynamic> _errorRoute() {
  //   return CupertinoPageRoute(builder: (context) {
  //     return Scaffold(
  //       appBar: AppBar(title: const Text("Error")),
  //       body: errorWidgetPage(
  //         context, "Gagal Mengakses Halaman",
  //         "Mohon coba akses beberapa saat lagi",
  //         // imagePath: AssetImageDrawable.errorPageNotFoundSvg
  //       ),
  //     );
  //   });
  // }

  // Navigate using the page name, `Navigator.pushNamed(context, ListPage.name)`.
  static Widget buildPage(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      // //On Splash Screen
      // case SplashScreen.routeName:
      //   final value = args as SplashScreenArguments;
      //   SplashScreenArguments data = value;
      //   return SplashScreen(
      //     splashTime: data.splashTime,
      //     pageLoad: data.pageLoad,
      //   );

      // case LoginPage.routeName:
      //   // final value = args as LoginPageArguments;
      //   // LoginPageArguments data = value;
      //   return const LoginPage();

      //On Home Page
      case HomePage.routeName:
        final value = args as HomePageArguments;
        HomePageArguments data = value;
        return const HomePage(
            // profile: data.profile,
            // device: data.device,
            // deviceData: data.deviceData,
            );

      // //On Settings Page
      // case SettingsPage.routename:
      //   final value = args as SettingsPageArguments;
      //   SettingsPageArguments data = value;
      //   return SettingsPage(
      //     deviceModel: data.deviceModel,
      //     profile: data.profile,
      //   );

      //On Settings Page
      //   case SettingsPage.routename:
      //     final value = args as SettingsPageArguments;
      //     SettingsPageArguments data = value;
      //     return SettingsPage(
      //       deviceData: data.deviceData,
      //       deviceModel: data.deviceModel,
      //     );

      //@Input Data Page Route
      // case IntroductionScreenPage.routeName:
      //   return CupertinoPageRoute(
      //       settings: settings, builder: (context) => IntroductionScreenPage());
      //
      // //@Bottom Navigation Page
      // case BottomNavigation.routeName:
      //   final data = args as BottomNavigationArguments;
      //   return CupertinoPageRoute(
      //     settings: settings,
      //     builder: (context) => BottomNavigation(
      //       pageLoad: data.pageLoad,
      //       profileData: data.profileData,
      //     )
      //   );
      //
      // case BottomNavigation.routeName:
      //   final data = args as BottomNavigationArguments;
      //   return CupertinoPageRoute(
      //       settings: settings,
      //       builder: (context) => BottomNavigation(
      //             pageLoad: data.pageLoad,
      //             profileData: data.profileData,
      //           ));
      //
      // //@Home
      // case HomePage.routeName:
      //   final data = args as HomePageArguments;
      //   return CupertinoPageRoute(
      //       settings: settings,
      //       builder: (context) => HomePage(
      //             profileData: data.profileData,
      //           ));
      //
      // //@Profile Page
      // case ProfilePage.routeName:
      //   final data = args as ProfilePageArguments;
      //   return CupertinoPageRoute(
      //       settings: settings,
      //       builder: (context) => ProfilePage(
      //             profileData: data.profileData,
      //           ));

      default:
        return const ErrorNotFoundPage();
    }
  }
}

// //@Error Route
// Route<dynamic> _errorRoute() {
//   return CupertinoPageRoute(builder: (context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Error")),
//       body: errorWidgetPage(
//         context,
//         "Gagal Mengakses Halaman",
//         "Mohon coba akses beberapa saat lagi",
//         imagePath: AssetImageDrawable.emptySvg,
//       ),
//     );
//   });
// }

// //======ARGUMENT CLASS======
class SplashScreenArguments {
  int splashTime;
  int pageLoad;
  String? status;

  SplashScreenArguments(
      {required this.splashTime, required this.pageLoad, this.status});
}

class LoginPageArguments {
  // LoginPageArguments({required this.login});
}
//
// //@Bottom Navigation Arguments
// class BottomNavigationArguments {
//   final int pageLoad;
//   final ProfileModel profileData;
//
//   BottomNavigationArguments(
//       {required this.pageLoad, required this.profileData});
// }

//@Home Page Arguments
class HomePageArguments {
  // HomePageArguments({});
}

// //@Settings Page Arguments
// class SettingsPageArguments {
//   final DeviceModel deviceModel;
//   final ProfileModel profile;
//
//   SettingsPageArguments({
//     required this.deviceModel,
//     required this.profile,
//   });
// }
