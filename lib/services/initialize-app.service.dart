//import 'package:flutter/material.dart';
//import 'dart:io';
//import 'dart:async';
//import 'dart:convert';
//
///** plugins */
////import 'package:background_fetch/background_fetch.dart';
////import 'package:leloo/services/shared-preferences.service.dart';
////import 'package:timeago/timeago.dart' as timeago;
////import 'package:geolocator/geolocator.dart';
////import 'package:dio/dio.dart';
////import 'package:shared_preferences/shared_preferences.dart';
////import 'package:flutter_crashlytics/flutter_crashlytics.dart';
//
///** commons */
////import 'package:leloo/env.dart';
////import 'package:leloo/utils/Helper.dart';
//
///** services */
////import 'package:leloo/services/auth.service.dart';
////import 'package:leloo/services/common.service.dart';
////import 'package:leloo/services/permission.service.dart';
////import 'package:leloo/services/all_translations.service.dart';
////import 'package:leloo/services/user.service.dart';
//
///** pages */
////import 'package:leloo/main.dart';
//
///// This "Headless Task" is run when app is terminated.
////void backgroundFetchHeadlessTask() async {
////  print('[BackgroundFetch] Headless event received.');
////
////  BaseOptions options = BaseOptions(
////      baseUrl: Env.value.baseUrl, connectTimeout: 5000, receiveTimeout: 5000, responseType: ResponseType.json,
////      // contentType: ContentType.parse("application/x-www-form-urlencoded"),
////      headers: {'Authorization': 'Bearer ' + await sharedPreferenceService.token});
////
////  Dio dio = Dio(options);
////
////  String url = '/report';
////  String body = json.encode({'subject': 'HEADLESS_EVENT ERROR', 'message': 'Non funziona perché...'});
////  await dio.post(url, data: body);
////
////  try {
////    String emailText = await Helper.createMailBody(body: 'Headless event received.');
////    userService.sendFeedback({'subject': 'HEADLESS_EVENT', 'message': emailText});
////    if (await appAuth.isLogged() && await appPermission.checkIfPermissionGranted()) {
////      Geolocator geolocator = Geolocator();
////      Position position = await geolocator.getCurrentPosition();
////      if (position != null) {
////        userService.updateUser({'longitude': position.longitude, 'latitude': position.latitude});
////      }
////    }
////    BackgroundFetch.finish();
////  } catch (error) {
////    String url = '/report';
////    String body = json.encode({'subject': 'HEADLESS_EVENT ERROR', 'message': 'Non funziona perché: $error'});
////    await dio.post(url, data: body);
////    print('ERROR background fetching: $error');
////    BackgroundFetch.finish();
////  }
////}
//
///// Prepare app before loading the first widget
//Future initializeBeforeBootstrapApp() async {
//  String language = Platform.localeName.substring(0, 2);
//  WidgetsFlutterBinding.ensureInitialized();
//  await sharedPreferenceService.getSharedPreferencesInstance();
//  await allTranslations.init(language);
//  if (language == 'it') {
//    timeago.setLocaleMessages(language, timeago.ItMessages());
//  } else {
//    timeago.setLocaleMessages(language, timeago.EnMessages());
//  }
//
//  String appVersion = await commonService.getAppVersion();
//
//  /** check if version is outdated and force user to update */
//  String _firstPage = await commonService.getFirstPage();
//
//  /** To handle error on all around the app. Please refer github.com/flutter/crashy */
//  FlutterError.onError = (FlutterErrorDetails details) {
//    if (Helper.isInDebugMode) {
//      // In development mode simply print to console.
//      FlutterError.dumpErrorToConsole(details);
//    } else {
//      // In production mode report to the application zone to report to Sentry.
//      Zone.current.handleUncaughtError(details.exception, details.stack);
//    }
//  };
//
//  await FlutterCrashlytics().initialize();
//  FlutterCrashlytics().setInfo('release', appVersion);
//
//  runZoned<Future<Null>>(() async {
//    runApp(MyApp(_firstPage));
//  }, onError: (error, stackTrace) async {
//    await Helper.reportError(error, stackTrace);
//  });
//
//  // Register to receive BackgroundFetch events after app is terminated.
//  // Requires {stopOnTerminate: false, enableHeadless: true}
//  // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
//}
