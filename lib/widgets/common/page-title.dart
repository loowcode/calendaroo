import 'package:calendaroo/colors.dart';
import 'package:calendaroo/services/navigation.service.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatefulWidget {
  final String title;

  PageTitle(this.title);

  @override
  _TitleState createState() => _TitleState();
}

class _TitleState extends State<PageTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: <Widget>[
          Text(widget.title,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline4),
          IconButton(
              onPressed: () {
                NavigationService().pop();
              },
              icon: Icon(
                Icons.close,
                color: secondaryLightGrey,
              ))
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
