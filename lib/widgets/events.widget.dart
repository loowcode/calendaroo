import 'package:flutter/cupertino.dart';

import '../colors.dart';

class EventsWidget extends StatefulWidget {
  @override
  _EventsWidgetState createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 10,
            width: 100,
            child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  color: secondaryLightGrey, borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }
}
