import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/common/notification_service.dart';
import 'feature/first_page/presentation/first_page.dart';
import 'firebase_options.dart';


Future<void> backgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
  final PushNotificationService _notificationService = PushNotificationService();
  

    MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    _notificationService.initialize();
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FirstPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
