import 'package:flutter/material.dart';

class WrapperTest extends StatefulWidget {
  final Widget child;

  WrapperTest(this.child);

  @override
  State createState() => WrapperTestState();
}

class WrapperTestState extends State<WrapperTest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: widget.child),
    );
  }
}
