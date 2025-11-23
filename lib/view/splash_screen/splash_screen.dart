import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/asset_drawable/asset_image_drawable.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/global/global_var.dart';
import 'package:rsufamilyhusadacare_mobile/view_model/reference.dart';

class SplashScreen extends HookConsumerWidget {
  static const routeName = '/splash';
  final int splashTime;
  final int pageLoad;
  final String? status;

  const SplashScreen(
      {Key? key, required this.splashTime, required this.pageLoad, this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ValueNotifier<String> appVersion = useState("");
    //Statefull widget lifecycle
    useEffect(() {
      //Init State
      ref
          .read(splashScreenViewModel.notifier)
          .initSplash(splashTime, pageLoad, context, ref);

      //Dispose
      return () {};
    }, //Did Update Widget,
        // Null -> fires every change,
        // empty list -> fires only once on the first time,
        // list with items: fires when any of the items on the list change.
        []);

    // final splashScreenState = ref.watch(splashScreenViewModel);
    // final splashScreenNotifier = ref.watch(splashScreenViewModel.notifier);

    //Call Inherited Widget (cant read MediaQuery.of)
    ref.read(splashScreenViewModel.notifier).initDevice(context, status);

    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            Flexible(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image.asset(
                    AssetImageDrawable.logoRsPng,
                    // fit: BoxFit.contain,
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.03,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //@Version
                  Builder(builder: (context) {
                    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
                      appVersion.value = packageInfo.version;
                    });

                    return AutoSizeText(
                      "V${appVersion.value}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    );
                  }),

                  const SizedBox(
                    height: 16,
                  ),

                  //@Image Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // //@Logo Kota Denpasar
                      // Image.asset(
                      //   AssetImageDrawable.lambangDenpasarPng,
                      //   fit: BoxFit.contain,
                      //   width: 40,
                      //   height: 40,
                      // ),

                      //@Spacing
                      //@Text Version

                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width * 0.05,
                      // ),

                      //@Text Pemerintah
                      Flexible(
                        child: AutoSizeText(
                          "Copyright © ${App.instance.getTimeZone().year} - RSU Famili Husada Mobile",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
