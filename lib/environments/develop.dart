import 'package:calendaroo/constants.dart';
import 'package:calendaroo/main.dart';
import 'package:calendaroo/services/initializer-app.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  Future(() {
    InitializerAppService().setUp(DEVELOP, VERSION);
  });
  runApp(MyApp());
}
