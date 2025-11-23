import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rsufamilyhusadacare_mobile/view_component/view_component.dart';

class MyTheme {
  static lightTheme(BuildContext context) {
    return FlexThemeData.light(
      appBarStyle: FlexAppBarStyle.material,
      colors: const FlexSchemeColor(
        primary: Color(0xff96c77f),
        primaryContainer: Color(0xffffffff),
        secondary: Color(0xffF3FDE8),
        secondaryContainer: Color(0xffffffff),
        tertiary: Color(0xffFFE5E5),
        tertiaryContainer: Color(0xffffffff),
        appBarColor: Color(0xffffffff),
        error: Color(0xffb00020),
        // swapOnMaterial3: true,
      ),
      usedColors: 2,
      // primaryTextTheme: TextTheme(
      //   bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(
      //         color: colorBlack(),
      //       ),
      // ),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      surfaceTint: colorWhite(),
      blendLevel: 9,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        blendTextTheme: false,
        cardRadius: 12.0,
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }

  static darkTheme(BuildContext context) {
    return FlexThemeData.dark(
      appBarStyle: FlexAppBarStyle.material,
      colors: const FlexSchemeColor(
        primary: Color(0xffdec6a9),
        primaryContainer: Color(0xff00325b),
        secondary: Color(0xffffb59d),
        secondaryContainer: Color(0xff872100),
        tertiary: Color(0xff86d2e1),
        tertiaryContainer: Color(0xff004e59),
        appBarColor: Color(0xff872100),
        error: Color(0xffcf6679),
      ),
      usedColors: 2,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 15,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        cardRadius: 12.0,
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      textTheme: GoogleFonts.robotoTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }
}
