import 'package:calendaroo/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static get primaryTheme {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      backgroundColor: primaryWhite,
      accentColor: accentYellow,
      primaryColor: primaryWhite,
      buttonColor: secondaryBlue,
      // hintColor: accentYellow,
      // canvasColor: accentYellow,
//      scaffoldBackgroundColor: primaryWhite,
//      cardColor: itemVeryLightGrayMostlyWhite,
      textSelectionColor: accentYellow,
//      errorColor: errorStrongRed,
      textTheme: _buildPrimaryTextTheme(base.textTheme),
//      primaryTextTheme: _buildPrimaryTextTheme(base.primaryTextTheme),
//      accentTextTheme: _buildPrimaryTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(color: secondaryDarkBlue),
      // buttonTheme: ButtonThemeData(),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryBlue, width: 2.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryBlue, width: 2.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryBlue, width: 2.0)),
      ),
    );
  }

  static TextTheme _buildPrimaryTextTheme(TextTheme base) {
    return base
        .copyWith(
          headline: base.headline.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
          title: base.title.copyWith(
            fontSize: 24.0,
            fontWeight: FontWeight.normal,
          ),
          subtitle: base.subtitle.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: secondaryDarkGrey
          ),
          body1: base.body1.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: primaryBlack,
          ),
          body2: base.body2.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
            color: primaryWhite,
          ),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 24.0,
          ),
          button: base.button.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: primaryWhite
          ),
        )
        .apply(
          fontFamily: 'SourceSansPro',
        );
  }

  static get secondaryTheme {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
//      backgroundColor: secondaryBlue,
      accentColor: accentYellow,
      primaryColor: primaryWhite,
      buttonColor: secondaryBlue,
//      appBarTheme: AppBarTheme(color: secondaryBlue, elevation: 0.0),
      // hintColor: accentYellow,
//      canvasColor: secondaryBlue,
      scaffoldBackgroundColor: secondaryBlue,
      cardColor: secondaryBlue,
      textSelectionColor: accentYellow,
//      errorColor: errorStrongRed,
      textTheme: _buildPrimaryTextTheme(base.textTheme),
      primaryTextTheme: _buildPrimaryTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildPrimaryTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(color: secondaryDarkBlue),
      // buttonTheme: ButtonThemeData(),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryBlue, width: 2.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryBlue, width: 2.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryBlue, width: 2.0)),
      ),
    );
  }

  static get datePicker {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: secondaryBlue,
      accentColor: secondaryBlue,
      dialogBackgroundColor: primaryWhite,
    );
  }

  static TextTheme _buildSecondaryTextTheme(TextTheme base) {
    return base
        .copyWith(
          headline: base.headline.copyWith(
            fontWeight: FontWeight.w500,
            color: primaryWhite,
          ),
          title: base.title.copyWith(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: primaryWhite,
          ),
          body1: base.body1.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: primaryWhite,
          ),
          body2: base.body2.copyWith(
            fontSize: 20.0,
            color: primaryWhite,
          ),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 32.0,
            color: primaryWhite,
          ),
        )
        .apply(
          fontFamily: 'SourceSansPro',
          bodyColor: primaryWhite,
        );
  }
}

const MaterialColor buttonTextColor = const MaterialColor(
  0xFF4A5BF6,
  const <int, Color>{
    50: const Color(0xFF4A5BF6),
    100: const Color(0xFF4A5BF6),
    200: const Color(0xFF4A5BF6),
    300: const Color(0xFF4A5BF6),
    400: const Color(0xFF4A5BF6),
    500: const Color(0xFF4A5BF6),
    600: const Color(0xFF4A5BF6),
    700: const Color(0xFF4A5BF6),
    800: const Color(0xFF4A5BF6),
    900: const Color(0xFF4A5BF6),
  },
);
