import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static void showEmergencyAlert() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Avengers Emergency Alert!',
        body: 'Nick Fury is calling! Too many missions are pending.',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}
