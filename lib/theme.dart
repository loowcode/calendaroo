import 'package:calendaroo/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get primaryTheme {
    final base = ThemeData.light();
    return base.copyWith(
      appBarTheme: _buildAppBarTheme(base),
      backgroundColor: white,
      accentColor: yellow,
      primaryColor: white,
      buttonColor: blue,
      // hintColor: accentYellow,
      canvasColor: transparent,

//      scaffoldBackgroundColor: primaryWhite,
//      cardColor: itemVeryLightGrayMostlyWhite,
      textSelectionColor: yellow,
//      errorColor: errorStrongRed,
      textTheme: _buildPrimaryTextTheme(base.textTheme),
//      primaryTextTheme: _buildPrimaryTextTheme(base.primaryTextTheme),
//      accentTextTheme: _buildPrimaryTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(color: darkBlue),
      inputDecorationTheme: InputDecorationTheme(
        border:
            OutlineInputBorder(borderSide: BorderSide(color: blue, width: 2.0)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: blue, width: 2.0)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: blue, width: 2.0)),
      ),
    );
  }

  static TextTheme _buildPrimaryTextTheme(TextTheme base) {
    return base
        .copyWith(
          // Title Page
          headline4: base.headline4.copyWith(
            fontSize: 34,
            color: black,
            fontWeight: FontWeight.w700,
          ),
          // Title heading
          headline5: base.headline5.copyWith(
            fontSize: 22,
            color: black,
            fontWeight: FontWeight.w700,
          ),
          // Text bold
          subtitle1: base.subtitle1.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: black,
          ),
          // Subtext bold
          subtitle2: base.subtitle2.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: grey,
          ),
          // Text normal
          bodyText1: base.bodyText1.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: black,
          ),
          // Subtext normal
          bodyText2: base.bodyText2.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: grey,
          ),
          // Caption (like Subtext but with lightgrey)
          caption: base.caption.copyWith(
            fontWeight: FontWeight.normal,
            color: lightGrey,
            fontSize: 16,
          ),
          button: base.button.copyWith(
            fontWeight: FontWeight.bold,
            color: white,
          ),
        )
        .apply(
          fontFamily: 'SourceSansPro',
        );
  }

  static ThemeData get secondaryTheme {
    final base = ThemeData.light();
    return base.copyWith(
//      backgroundColor: secondaryBlue,
      accentColor: yellow,
      primaryColor: white,
      buttonColor: blue,
//      appBarTheme: AppBarTheme(color: secondaryBlue, elevation: 0.0),
      // hintColor: accentYellow,
//      canvasColor: secondaryBlue,
      scaffoldBackgroundColor: blue,
      cardColor: blue,
      textSelectionColor: yellow,
//      errorColor: errorStrongRed,
      textTheme: _buildSecondaryTextTheme(base.textTheme),
      primaryTextTheme: _buildSecondaryTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildSecondaryTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(color: darkBlue),
      // buttonTheme: ButtonThemeData(),
      inputDecorationTheme: InputDecorationTheme(
        border:
            OutlineInputBorder(borderSide: BorderSide(color: blue, width: 2.0)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: blue, width: 2.0)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: blue, width: 2.0)),
      ),
    );
  }

  static ThemeData get datePicker {
    final base = ThemeData.light();
    return base.copyWith(
      primaryColor: blue,
      accentColor: blue,
      dialogBackgroundColor: white,
    );
  }

  static AppBarTheme _buildAppBarTheme(ThemeData base) {
    return AppBarTheme(textTheme: _buildPrimaryTextTheme(base.textTheme));
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
              color: darkGrey),
          bodyText2: base.bodyText2.copyWith(
//            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: white,
          ),
          bodyText1: base.bodyText1.copyWith(
//            fontSize: 20.0,
            fontWeight: FontWeight.normal,
            color: white,
          ),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.normal,
//            fontSize: 24.0,
          ),
          button: base.button.copyWith(
              fontWeight: FontWeight.bold,
//              fontSize: 24.0,
              color: white),
        )
        .apply(
          fontFamily: 'SourceSansPro',
        );
  }
}
