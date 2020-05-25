import 'package:calendaroo/constants.dart';
import 'package:calendaroo/main.dart';
import 'package:calendaroo/services/initializer-app.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO: main have too much work and some frames are skipped
void main() async {
  await InitializerAppService().setUp(DEVELOP, VERSION);
  runApp(MyApp());
}
