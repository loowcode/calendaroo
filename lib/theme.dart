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
//      textTheme: _buildPrimaryTextTheme(base.textTheme),
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
          fontFamily: 'IBMPlexSans',
//      bodyColor: textVeryDarkBlue,
        );
  }
}
