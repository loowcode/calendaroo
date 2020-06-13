import 'package:calendaroo/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get primaryTheme {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      appBarTheme: _buildAppBarTheme(base),
      backgroundColor: primaryWhite,
      accentColor: accentYellow,
      primaryColor: primaryWhite,
      buttonColor: secondaryBlue,
      // hintColor: accentYellow,
      canvasColor: transparent,

//      scaffoldBackgroundColor: primaryWhite,
//      cardColor: itemVeryLightGrayMostlyWhite,
      textSelectionColor: accentYellow,
//      errorColor: errorStrongRed,
      textTheme: _buildPrimaryTextTheme(base.textTheme),
//      primaryTextTheme: _buildPrimaryTextTheme(base.primaryTextTheme),
//      accentTextTheme: _buildPrimaryTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(color: secondaryDarkBlue),
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
      // Title Page
      headline4: base.headline4.copyWith(
        fontSize: 36,
        color: primaryBlack,
        fontWeight: FontWeight.w700,
      ),
      // Title heading
      headline5: base.headline5.copyWith(
        fontSize: 24,
        color: primaryBlack,
        fontWeight: FontWeight.w700,
      ),
      headline6: base.headline6.copyWith(
        fontWeight: FontWeight.w600,
      ),
      subtitle1: base.subtitle1.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        color: secondaryGrey,
      ),
      subtitle2: base.subtitle2.copyWith(
        fontWeight: FontWeight.w600,
        color: secondaryDarkGrey,
      ),
      // Text
      bodyText1: base.bodyText1.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: primaryWhite,
      ),
      // SubText
      bodyText2: base.bodyText2.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        color: secondaryGrey,
      ),
      // Caption (is like Subtext but with lightgrey)
      caption: base.caption.copyWith(
        fontWeight: FontWeight.normal,
        color: secondaryLightGrey,
        fontSize: 16,
      ),
      button: base.button.copyWith(
        fontWeight: FontWeight.bold,
        color: primaryWhite,
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

  static get datePicker {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: secondaryBlue,
      accentColor: secondaryBlue,
      dialogBackgroundColor: primaryWhite,
    );
  }

  static AppBarTheme _buildAppBarTheme(ThemeData base){
    return AppBarTheme(
      textTheme: _buildPrimaryTextTheme(base.textTheme)
    );
  }

  static TextTheme _buildSecondaryTextTheme(TextTheme base) {
    return base
        .copyWith(
      headline4: base.headline4.copyWith(
//            fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      headline5: base.headline5.copyWith(
//            fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      subtitle1: base.subtitle1.copyWith(
//            fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
      headline6: base.headline6.copyWith(
//            fontSize: 24.0,
        fontWeight: FontWeight.normal,
      ),
      subtitle2: base.subtitle2.copyWith(
//              fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: secondaryDarkGrey),
      bodyText2: base.bodyText2.copyWith(
//            fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: primaryWhite,
      ),
      bodyText1: base.bodyText1.copyWith(
//            fontSize: 20.0,
        fontWeight: FontWeight.normal,
        color: primaryWhite,
      ),
      caption: base.caption.copyWith(
        fontWeight: FontWeight.normal,
//            fontSize: 24.0,
      ),
      button: base.button.copyWith(
          fontWeight: FontWeight.bold,
//              fontSize: 24.0,
          color: primaryWhite),
    )
        .apply(
      fontFamily: 'SourceSansPro',
    );
  }
}


