// ignore_for_file: file_names

import 'package:boss/constants/prefs_const.dart';
import 'package:boss/models/user_model.dart';
import 'package:boss/pages/homePage/board_page.dart';
import 'package:boss/pages/homePage/notification_page.dart';
import 'package:boss/pages/homePage/setting_page.dart';
import 'package:boss/pages/homePage/stats_page.dart';
import 'package:boss/providers/language_provider.dart';
import 'package:boss/providers/notificationItem_provider.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/resources/resources.dart';
import 'package:boss/services/push_notification.dart';
import 'package:boss/widgets/components/logoSingleton_widget.dart';
import 'package:boss/widgets/main/appBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String example = "";

  final List<Widget> _screens = [
    const BoardPage(),
    const StatsPage(),
    const NotificationPage(),
    const SettingPage(),
  ];

  final List<IconData> _icons = [
    Icons.account_balance_wallet_rounded,
    Icons.table_chart_rounded,
    Icons.notifications_active,
    Icons.person_sharp,
  ];
  final PageController _pageController = PageController();

  String nameEmpresa = "";
  final Future<SharedPreferences> _prefsFuture =
      SharedPreferences.getInstance();

  @override
  void initState() {
    /*FirebaseApi pushNoti = FirebaseApi();
    pushNoti.initNotifications(context);
    pushNoti.message.listen((arg) {
      //example = arg;
 });*/
    _prefsFuture.then((SharedPreferences prefs) async {
      if ((prefs.getString(PrefsConstants.prefsUser) ?? "") != "") {
        UserModel user =
            userModelFromJson(prefs.getString(PrefsConstants.prefsUser)!);
        setState(() {
          nameEmpresa = user.empresa.nombre;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    NotificationItemProvider watchItemNotification =
        context.watch<NotificationItemProvider>();

    List<String> titles = [
      watchLanguage.languageTexts!.pages.board.title,
      watchLanguage.languageTexts!.pages.stats.title,
      watchLanguage.languageTexts!.pages.notifications.title,
      watchLanguage.languageTexts!.pages.settings.title,
    ];

    List<String> subTitles = [
      watchLanguage.languageTexts!.pages.board.subTitle,
      watchLanguage.languageTexts!.pages.stats.subTitle,
      watchLanguage.languageTexts!.pages.notifications.subTitle,
      watchLanguage.languageTexts!.pages.settings.subTitle,
    ];
    return Scaffold(
      appBar: MyAppBarWidget(
        leading: Icon(_icons[_currentIndex]),
        title: titles[_currentIndex],
        subTitle: subTitles[_currentIndex],
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingMedium),
            child: Text(nameEmpresa),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: watchTheme.colors.background,
          selectedItemColor: watchTheme.colors.white,
          unselectedItemColor: watchTheme.colors.lightPrimary,
          items: [
            BottomNavigationBarItem(
              label: 'Datos',
              icon: Icon(_icons[0]),
            ),
            BottomNavigationBarItem(
              label: 'Datos',
              icon: Icon(_icons[1]),
            ),
            BottomNavigationBarItem(
              label: 'Datos',
              icon: Stack(children: [
                Icon(_icons[2]),
                watchItemNotification.listItemNotifications
                            .where((item) => item.state == true)
                            .toList()
                            .length >
                        0
                    ? Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                          color: watchTheme.colors.active,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            watchItemNotification.listItemNotifications
                                .where((item) => item.state == true)
                                .toList()
                                .length
                                .toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ]),
            ),
            BottomNavigationBarItem(
              label: 'Config',
              icon: Icon(_icons[3]),
            ),
          ],
        ),
      ),
      body: Stack(children: [
        Center(child: MyLogoSingletonWidget(size: 200)),
        PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        //Text("data"),
      ]),
    );
  }
}
