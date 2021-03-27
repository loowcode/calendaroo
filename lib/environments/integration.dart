import 'package:calendaroo/constants.dart';
import 'package:calendaroo/main.dart';
import 'package:calendaroo/services/initializer_app.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  await InitializerAppService().setUp(INTEGRATION);
  runApp(MyApp());
}
