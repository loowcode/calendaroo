import 'package:flutter/cupertino.dart';


@immutable
class AppStatusState {
  final AppStatus appStatus;

  AppStatusState({this.appStatus});

  factory AppStatusState.initial() {
    return AppStatusState(appStatus: AppStatus.INIT);
  }

  AppStatusState copyWith({AppStatus appStatus}) {
    return AppStatusState(appStatus: appStatus ?? this.appStatus);
  }
}

enum AppStatus { INIT, LOADING, STARTED, RUNNING, PAUSED }
