abstract class State {}

class AppState extends State {
  FlowState flowState;
  CalendarState calendarState;
}

class InitialState extends AppState {}

class MockInitialState extends InitialState {
  MockInitialState() {
    this.flowState = FlowState(Flow.STARTED);
    List<String> events;
    events.add('event');
    this.calendarState = CalendarState(events);
  }
}

class CalendarState extends State {
  List<String> events;

  CalendarState(this.events);
}

class FlowState extends State {
  Flow flow;

  FlowState(this.flow);
}

enum Flow { LOADING, STARTED }
