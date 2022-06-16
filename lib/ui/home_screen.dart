import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/ui/detail_screen.dart';
import 'package:restaurant_app/ui/resto_list_page.dart';
import 'package:restaurant_app/ui/setting_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favorites_page.dart';

class HomeRestoScreen extends StatefulWidget {
  const HomeRestoScreen({Key? key}) : super(key: key);
  static const routeName = '/home_screen';

  @override
  State<HomeRestoScreen> createState() => _HomeRestoScreenState();
}

class _HomeRestoScreenState extends State<HomeRestoScreen> {
  int _bottomNavIndex = 0;
  static const String _homeText = 'Home';
  static const String _favoritesText = 'Favorites';
  static const String _settingsText = 'Setting';

  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    const RestoListPage(),
    const FavoritesPage(),
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance())),
        )
      ],
      child: const SettingPage(),
    )
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: _homeText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: _favoritesText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: _settingsText,
    ),
  ];

  void _onBottomNavTaped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: _onBottomNavTaped,
        items: _bottomNavBarItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildAndroid,
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailRestoScreen.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
