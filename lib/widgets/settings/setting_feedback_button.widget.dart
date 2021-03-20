import 'package:calendaroo/services/app-localizations.service.dart';
import 'package:calendaroo/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingFeedbackButton extends StatefulWidget {
  @override
  _SettingFeedbackButtonState createState() => _SettingFeedbackButtonState();
}

class _SettingFeedbackButtonState extends State<SettingFeedbackButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context).feedback,
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              primary: AppTheme.primaryTheme.buttonColor,
              onPrimary: AppTheme.primaryTheme.textTheme.button.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              _launchEmailUrl();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(AppLocalizations.of(context).sendFeedback),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              AppLocalizations.of(context).feedbackInfo,
              style: AppTheme.primaryTheme.textTheme.bodyText1.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchEmailUrl() async {
    var url = 'mailto:loowcode@gmail.com?subject=Feedback';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showAlert(
        context: context,
        title: AppLocalizations.of(context).warning,
        body: AppLocalizations.of(context).warningNoEmailApp,
        barrierDismissible: true,
      );
    }
  }
}
