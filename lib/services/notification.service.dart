import 'package:calendaroo/dao/event-instances.repository.dart';
import 'package:calendaroo/model/event.model.dart';
import 'package:calendaroo/model/notification-channel.model.dart';
import 'package:calendaroo/utils/notification.utils.dart';
import 'package:intl/intl.dart';

class NotificationService {
  Future<void> scheduleForEvent(Event event) async {
    // TODO: use DatabaseService instead?
    var eventInstances =
        await EventInstanceRepository().findByEventId(event.id);

    var formatterTime = DateFormat.Hm();

    // TODO: instantiate once
    var eventNotificationChannel = NotificationChannel(
        'event_notification', 'Notifiche evento', 'Mostra le notifiche evento');

    // TODO: limit notification? what if an event has infinite duration? use "near" concept and reschedule periodically?
    for (var eventInstance in eventInstances) {
      await scheduleNotification(
          eventInstance.id,
          event.title,
          '${formatterTime.format(eventInstance.start)} - ${formatterTime.format(eventInstance.end)}',
          eventInstance.start,
          eventInstance.id.toString(),
          eventNotificationChannel);
    }
  }

  Future<void> cancelForEvent(Event event) async {
    // TODO: use DatabaseService instead?
    var eventInstances =
        await EventInstanceRepository().findByEventId(event.id);

    // TODO: limit notification? what if an event has infinite duration? use "near" concept and re-cancelling periodically?
    for (var eventInstance in eventInstances) {
      await cancelNotification(eventInstance.id);
    }
  }

  Future<void> rescheduleForEvent() async {
    // TODO: "near" concept? used when the user reactivate notifications or periodically
    /*var today = Date.today();
    calendarooState.state.calendarState.eventMapped.forEach((key, value) {
      if (today.compareTo(key) <= 0) {
        value.forEach((element) {
          if (today.isBefore(element.start)) {
            scheduleNotification(element);
          }
        });
      }
    });*/
  }
}
