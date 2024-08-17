import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_score/app.dart';
import 'package:live_score/firebase_notification_service.dart';
import 'package:live_score/local_notification_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotificationService.instance.initialize();

  LocalNotificationService.instance.initialize();

  runApp(const MyApp());
}
