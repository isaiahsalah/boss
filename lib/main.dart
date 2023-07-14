import 'package:boss/pages/FilterPage.dart';
import 'package:boss/pages/HomePage.dart';
import 'package:boss/pages/homePage/notificationPages/NotificationCashClosurePage.dart';
import 'package:boss/pages/homePage/settingPages/SettingAboutPage.dart';
import 'package:boss/pages/homePage/settingPages/SettingGeneralPage.dart';
import 'package:boss/pages/homePage/settingPages/SettingHelpPage.dart';
import 'package:boss/pages/homePage/settingPages/SettingNotificationPage.dart';
import 'package:boss/pages/homePage/settingPages/SettingProfilePage.dart';
import 'package:boss/pages/homePage/settingPages/SettingWidgetPage.dart';
import 'package:boss/pages/LoginPage.dart';
import 'package:boss/pages/TutorialPage.dart';
import 'package:boss/pages/homePage/statPages/StatFinancePage.dart';
import 'package:boss/pages/homePage/statPages/StatHumanResourcePage.dart';
import 'package:boss/pages/homePage/statPages/StatProductionPage.dart';
import 'package:boss/pages/homePage/statPages/StatSalesPage.dart';
import 'package:boss/pages/homePage/statPages/StatPurchasesPage.dart';
import 'package:boss/providers/FilterDateProvider.dart';
import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/NotificationItemProvider.dart';
import 'package:boss/providers/NotificationProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/providers/UserProvider.dart';
import 'package:boss/providers/WidgetShowProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<DateTimeProvider>(
              create: (_) => DateTimeProvider()),
          ChangeNotifierProvider<LanguageProvider>(
              create: (_) => LanguageProvider()),
          ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(),
          ),
          ChangeNotifierProvider<WidgetShowProvider>(
            create: (_) => WidgetShowProvider(),
          ),
          ChangeNotifierProvider<NotificationProvider>(
            create: (_) => NotificationProvider(),
          ),
          ChangeNotifierProvider<NotificationItemProvider>(
            create: (_) => NotificationItemProvider(),
          ),
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
        ],
        builder: (context, _) {
          return context.watch<LanguageProvider>().languageTexts == null
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Boss',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ))
              : MaterialApp(
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  theme: themeData(context),
                  routes: {
                    '/home': (context) => const HomePage(),
                    '/tutorial': (context) => const TutorialPage(),
                    '/login': (context) => const LoginPage(),
                    '/filter': (context) => const FilterPage(),

                    //Paginas de configuración
                    '/config/general': (context) => const GeneralPage(),
                    '/config/widgets': (context) => const WidgetPage(),
                    '/config/notifications': (context) =>
                        const NotificationPage(),
                    '/config/profile': (context) => const ProfilePage(),
                    '/config/help': (context) => const HelpPage(),
                    '/config/about': (context) => const AboutPage(),

                    //Paginas de estadisticas generales
                    '/stat/finance': (context) => const StatFinancePage(),
                    '/stat/sales': (context) => const StatSalesPage(),
                    '/stat/shopping': (context) => const StatPurchasesPage(),
                    '/stat/production': (context) => const StatProductionPage(),
                    '/stat/humanResources': (context) =>
                        const StatHumanResourcePage(),
                    '/not/cashClosure': (context) =>
                        const NotificationCashClosurePage(),
                  },
                  initialRoute: '/login',
                );
        });
  }
}

ThemeData themeData(BuildContext context) {
  ThemeProvider watchTheme = context.watch<ThemeProvider>();
  return ThemeData(
    snackBarTheme: SnackBarThemeData(
        backgroundColor: watchTheme.colors.lightBackground,
        actionTextColor: watchTheme.colors.white,
        contentTextStyle: TextStyle(
          color: watchTheme.colors.white,
        )),
    switchTheme: const SwitchThemeData(),
    dataTableTheme: DataTableThemeData(
      dataRowColor: MaterialStateProperty.all<Color>(Colors.transparent),
      headingRowColor: MaterialStateProperty.all<Color>(Colors.transparent),
    ),
    listTileTheme: ListTileThemeData(
        subtitleTextStyle: TextStyle(
      color: watchTheme.colors.lightPrimary,
    )),
    dividerTheme: DividerThemeData(
      color: watchTheme.colors.lightBackground,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: watchTheme.colors.primary,
      elevation: 3,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black,
      titleSpacing: 5,
    ),
    cardTheme: CardTheme(
      margin: EdgeInsets.zero,
      elevation: 5,
      color: watchTheme.colors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
    ),
    textTheme: Theme.of(context).textTheme.apply(
        fontFamily: GoogleFonts.nunito().fontFamily,
        decorationColor: watchTheme.colors.white,
        bodyColor: watchTheme.colors.white),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: watchTheme.colors.primary,
      background: watchTheme.colors.background,
      onPrimary: watchTheme.colors.white,
    ),
    useMaterial3: true,
  );
}
