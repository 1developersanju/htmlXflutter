import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification_service.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      print("Device Token: $token");
      // Send the token to your backend server if necessary
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message: ${message.messageId}');
      NotificationService.showNotification(
        message.notification?.title ?? 'New Notification',
        message.notification?.body ?? 'You have a new notification',
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification tapped: ${message.messageId}');
      // Handle notification tap
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Background message: ${message.messageId}');
    await NotificationService.showNotification(
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? 'You have a new notification',
    );
  }
}
