import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/resto_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/ui/detail_screen.dart';
import 'package:restaurant_app/ui/error_screen.dart';
import 'package:restaurant_app/ui/home_screen.dart';
import 'package:restaurant_app/ui/search_screen.dart';
import 'package:restaurant_app/ui/splash_screen.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

import 'common/navigation.dart';
import 'data/api_service/api_service.dart';
import 'data/model/restaurant.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestoProvider>(
          create: (_) => RestoProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(elevation: 0),
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                onPrimary: Colors.black,
                secondary: secondaryColor,
              ),
        ),
        navigatorKey: navigatorKey,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeRestoScreen.routeName: (context) => const HomeRestoScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          DetailRestoScreen.routeName: (context) => DetailRestoScreen(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant),
          ErrorScreen.routeName: (context) => const ErrorScreen(),
        },
      ),
    );
  }
}
