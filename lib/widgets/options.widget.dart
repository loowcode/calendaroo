import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/redux/actions/calendar.actions.dart';
import 'package:calendaroo/redux/states/app.state.dart';

class Option {
  Option({this.title, this.type, this.event});

  final String title;
  final OptionType type;
  Event event;

  Option setEvent(Event event) {
    this.event = event;
    return this;
  }
}

List<Option> options = <Option>[
  Option(title: 'Elimina', type: OptionType.REMOVE),
];

void selectOption(Option option) {
  if (option.type == OptionType.REMOVE) {
    calendarooState.dispatch(RemoveEvent(option.event));
  }
}

enum OptionType { REMOVE }
