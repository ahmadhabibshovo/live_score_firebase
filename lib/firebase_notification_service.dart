import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:live_score/local_notification_service.dart';

class FirebaseNotificationService {
  FirebaseNotificationService._();

  static final instance = FirebaseNotificationService._();
  final _firebaseMessage = FirebaseMessaging.instance;

  Future<void> initialize() async {
    final setting = await _firebaseMessage.requestPermission();

    FirebaseMessaging.onMessage.listen((remoteMessage) async {
      await LocalNotificationService.instance.sendNotification(
          title: remoteMessage.notification?.title ?? '',
          description: remoteMessage.notification?.body ?? '');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      print(remoteMessage.notification?.title);
      print(remoteMessage.notification?.body);
    });
    FirebaseMessaging.onBackgroundMessage(doNothing);
    final token = await _firebaseMessage.getToken();
    print(token);
  }

  Future<void> doNothing(remoteMessage) async {
    print(remoteMessage.notification?.title);
    print(remoteMessage.notification?.body);
  }
}
