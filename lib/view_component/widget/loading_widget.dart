import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_framework/responsive_framework.dart';

Widget showBasicLoading(BuildContext context) {
  return SpinKitThreeBounce(
    size: 30,
    color: Theme.of(context).colorScheme.primary,
  );
}

//@Fullscreen loading widget
Widget showFullscreenLoadingWidget(
    {required BuildContext context,
    required Color color,
    Color? scaffoldColor}) {
  return Scaffold(
    backgroundColor: (scaffoldColor != null)
        ? scaffoldColor
        : Theme.of(context).scaffoldBackgroundColor,
    body: SafeArea(
      child: Center(
        child: SpinKitThreeBounce(
          size: 30,
          color: color,
        ),
      ),
    ),
  );
}

//@Show Loading Page Widget
Widget showLoadingWidget(BuildContext context, Color color) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitThreeBounce(
          size: 30,
          color: color,
        )
      ],
    ),
  );
}

//@Show Loading Page Widget
Widget showLoadingCustomWidget(
    BuildContext context, Color color, String title, String subtitle,
    {Widget? widgetImage,
    CrossAxisAlignment? crossAxisAlignment,
    String? svgAsset}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Widet Label Text
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 0,
                maxHeight: MediaQuery.of(context).size.height * 0.5,
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: (crossAxisAlignment != null)
                    ? crossAxisAlignment
                    : CrossAxisAlignment.start,
                children: [
                  //Widget image
                  (widgetImage != null)
                      ? SizedBox(
                          height:
                              ResponsiveBreakpoints.of(context).screenHeight *
                                  0.3,
                          width: ResponsiveBreakpoints.of(context).screenWidth *
                              0.5,
                          child: widgetImage,
                        )
                      : const SizedBox(),

                  //@Header
                  Flexible(
                    child: AutoSizeText(
                      title,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontSize: 18,
                          ),
                    ),
                  ),

                  //@Spacing
                  const SizedBox(
                    height: 8,
                  ),

                  //@Sub Header
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //@Subtitle
                        Flexible(
                          child: AutoSizeText(
                            subtitle,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: Colors.grey.shade600),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        //Loading
        SpinKitThreeBounce(
          size: 30,
          color: color,
        )
      ],
    ),
  );
}

//@Show Loading When List Scroll Load
Widget showLoadingListScrollWidget(BuildContext context, Color color,
    {double bottomPadding = 8.0}) {
  return Padding(
    padding: EdgeInsets.only(bottom: bottomPadding),
    child: Center(
      child: SpinKitThreeBounce(
        color: color,
        size: 30,
      ),
    ),
  );
}

//@Halaman Terakhir Widget
Widget showLastPageScrollWidget(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 16.0),
    child: Center(
      child: AutoSizeText(
        'Halaman terakhir telah dicapai',
        maxLines: 1,
        minFontSize: 14,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
