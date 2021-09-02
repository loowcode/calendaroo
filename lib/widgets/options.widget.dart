import 'package:calendaroo/blocs/calendar/calendar_bloc.dart';
import 'package:calendaroo/services/app-localizations.service.dart';

class Option {
  final String title;
  final OptionType type;
  int eventId;

  Option({
    this.title,
    this.type,
    this.eventId,
  });

  Option setEvent(int eventId) {
    this.eventId = eventId;
    return this;
  }
}

List<Option> options = <Option>[
  Option(title: AppLocalizations.DELETE, type: OptionType.REMOVE),
];

void selectOption(CalendarBloc bloc, Option option) {

}

enum OptionType { REMOVE }
