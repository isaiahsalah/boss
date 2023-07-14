// ignore_for_file: file_names

import 'package:boss/pages/homePage/BoardPage.dart';
import 'package:boss/pages/homePage/NoficationPage.dart';
import 'package:boss/pages/homePage/SettingPage.dart';
import 'package:boss/pages/homePage/StatsPage.dart';
import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/widgets/main/MyAppBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();

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
        filter: true,
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
          backgroundColor: const Color(0xFF3B5A72),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xFFA7B5BF),
          items: [
            BottomNavigationBarItem(
              label: 'Panel',
              icon: Icon(_icons[0]),
            ),
            BottomNavigationBarItem(
              label: 'Datos',
              icon: Icon(_icons[1]),
            ),
            BottomNavigationBarItem(
              label: 'Datos',
              icon: Icon(_icons[2]),
            ),
            BottomNavigationBarItem(
              label: 'Config',
              icon: Icon(_icons[3]),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
