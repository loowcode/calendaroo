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
            fontWeight: FontWeight.w500,
          ),
          title: base.title.copyWith(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          body1: base.body1.copyWith(
            fontSize: 18.0,
          ),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 14.0,
//        color: Colors.,
          ),
        )
        .apply(
          fontFamily: 'SourceSansPro',
//      bodyColor: textVeryDarkBlue,
        );
  }

  static get secondaryTheme {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      backgroundColor: secondaryBlue,
      accentColor: accentYellow,
      primaryColor: primaryWhite,
      buttonColor: secondaryBlue,
      appBarTheme: AppBarTheme(color: secondaryBlue, elevation: 0.0),
      // hintColor: accentYellow,
       canvasColor: secondaryBlue,
      scaffoldBackgroundColor: secondaryBlue,
      cardColor: secondaryBlue,
      textSelectionColor: accentYellow,
//      errorColor: errorStrongRed,
      textTheme: _buildSecondaryTextTheme(base.textTheme),
      primaryTextTheme: _buildSecondaryTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildSecondaryTextTheme(base.accentTextTheme),
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

  static TextTheme _buildSecondaryTextTheme(TextTheme base) {
    return base
        .copyWith(
          headline: base.headline.copyWith(
            fontWeight: FontWeight.w500,
            color: secondaryLightBlue,
          ),
          title: base.title.copyWith(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: secondaryLightBlue,
          ),
          body1: base.body1.copyWith(
            fontSize: 20.0,
            color: secondaryLightBlue,
          ),
          body2: base.body2.copyWith(
            fontSize: 20.0,
            color: secondaryLightBlue,
          ),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 14.0,
            color: secondaryLightBlue,
          ),
        )
        .apply(
          fontFamily: 'SourceSansPro',
          bodyColor: secondaryLightBlue,
        );
  }
}
