import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/styles/colors.dart';

//@Show error widget and refresh icon with desc
Widget errorRefreshWidget(BuildContext context, String title, String subtitle,
    {String? imagePath}) {
  return Padding(
    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (imagePath != null)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //@Websae Asset
                    SvgPicture.asset(
                      imagePath,
                      height: 250,
                    ),

                    //@Spacing
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    )
                  ],
                )
              : const SizedBox(),

          //@Header
          Flexible(
            child: AutoSizeText(
              title,
              maxLines: 1,
              minFontSize: 14,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: 18,
                  ),
            ),
          ),

          //@Spacing
          const SizedBox(
            height: 8,
          ),

          //@SubHeader
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.arrow_drop_down_outlined,
                    color: Colors.grey.shade600),

                //@Subtitle
                Flexible(
                  child: AutoSizeText(
                    subtitle,
                    maxLines: 1,
                    minFontSize: 12,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
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
  );
}

//@Show error widget
Widget errorWidgetPage(BuildContext context, String title, String subtitle,
    {String? imagePath, Color? colorHeader, Color? colorMessage}) {
  return Padding(
    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (imagePath != null)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //@Websae Asset
                    SvgPicture.asset(
                      imagePath,
                      height: 250,
                    ),

                    //@Spacing
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    )
                  ],
                )
              : const SizedBox(),

          //@Header
          Flexible(
            child: AutoSizeText(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    color: (colorHeader != null) ? colorHeader : colorBlack(),
                  ),
            ),
          ),

          //@Spacing
          const SizedBox(
            height: 8,
          ),

          //@SubHeader
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //@Subtitle
                Flexible(
                  child: AutoSizeText(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: (colorMessage != null)
                              ? colorMessage
                              : Colors.grey.shade600,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

//@Show error widget
Widget errorWidget(BuildContext context, String title, String subtitle,
    {CrossAxisAlignment? crossAxisAlignment, String? svgAsset}) {
  return Padding(
    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
    child: ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height * 0.2,
        minWidth: MediaQuery.of(context).size.width,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: (crossAxisAlignment != null)
            ? crossAxisAlignment
            : CrossAxisAlignment.start,
        children: [
          (svgAsset != null)
              ? SvgPicture.asset(
                  svgAsset,
                  semanticsLabel: 'Empty Data',
                  height: 350,
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
  );
}

//@Show error widget
Widget errorWidgetUndraw(
  BuildContext context,
  String title,
  String subtitle, {
  CrossAxisAlignment? crossAxisAlignment,
  Widget? widgetImage,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
    child: ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height * 0.9 - kToolbarHeight,
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
                  height: ResponsiveBreakpoints.of(context).screenHeight * 0.3,
                  width: ResponsiveBreakpoints.of(context).screenWidth * 0.7,
                  child: widgetImage,
                )
              : const SizedBox(),

          const SizedBox(
            height: 16,
          ),

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
  );
}
