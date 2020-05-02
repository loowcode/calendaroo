abstract class AppState{}

class InitialState extends AppState{}

class CalendarState extends AppState{
  List<String> events;

  CalendarState(this.events);
}
