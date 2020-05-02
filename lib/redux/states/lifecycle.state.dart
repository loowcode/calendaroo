import 'app.state.dart';

class LifecycleState extends State {
  final Lifecycle lifecycle;

  LifecycleState({this.lifecycle});

  factory LifecycleState.initial() {
    return LifecycleState(lifecycle: Lifecycle.INIT);
  }

  LifecycleState copyWith({Lifecycle lifecycle}) {
    return LifecycleState(lifecycle: lifecycle ?? this.lifecycle);
  }
}

enum Lifecycle { INIT, LOADING, STARTED, RUNNING, PAUSED }
