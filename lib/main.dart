import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:planetoid_app/firebase_options.dart';
import 'package:planetoid_app/providers/auth_provider.dart';
import 'package:planetoid_app/providers/message_provider.dart';
import 'package:planetoid_app/utils/colors.dart';
import 'package:planetoid_app/utils/notifications/fcm_services.dart';
import 'package:planetoid_app/utils/notifications/local_notification_service.dart';
import 'package:planetoid_app/utils/routeGenerator.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize local notifications
  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');
  // final InitializationSettings initializationSettings =
  //     InitializationSettings(android: initializationSettingsAndroid);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  print("Initializing");
  await NotificationService.initialize();
  await FCMService().initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => MessageProvider()),

    // Add more providers as needed
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            clipBehavior: Clip.antiAlias,
          ),
          canvasColor: ColorsRes.canvasColor,
          inputDecorationTheme: InputDecorationTheme(
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(8.0),
            //   borderSide: const BorderSide(
            //     color: Colors.blue,
            //   ),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(8.0),
            //   borderSide: const BorderSide(
            //     color: Colors.blue,
            //   ),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(8.0),
            //   borderSide: const BorderSide(
            //     color: Colors.blue,
            //     width: 2.0,
            //   ),
            // ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
            ),
          ),
          cardTheme: CardTheme(color: ColorsRes.canvasColor)),
      initialRoute: splashScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
