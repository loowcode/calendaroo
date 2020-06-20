import 'package:calendaroo/dao/event-instances.repository.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/utils/notification.utils.dart';

class NotificationService {
  Future<void> scheduleForEvent(Event event) async {
    var eventInstances =
        await EventInstanceRepository().findByEventId(event.id);

    // TODO: limit notification? what if an event has infinite duration? use "near" concept and reschedule periodically?
    for (var eventInstance in eventInstances) {
      await scheduleNotification(eventInstance);
    }
  }

  Future<void> cancelForEvent(Event event) async {
    var eventInstances =
        await EventInstanceRepository().findByEventId(event.id);

    // TODO: limit notification? what if an event has infinite duration? use "near" concept and re-cancelling periodically?
    for (var eventInstance in eventInstances) {
      await cancelNotification(eventInstance.id);
    }
  }
}
