// Importaciones necesarias
import 'package:boss/providers/modules_provider.dart';
import 'package:boss/providers/refresh_provider.dart';
import 'package:boss/providers/widget_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Importa las páginas de la aplicación
import 'package:boss/pages/filter_page.dart';
import 'package:boss/pages/home_page.dart';
import 'package:boss/pages/homePage/notificationPages/notification_cashClosure_page.dart';
import 'package:boss/pages/homePage/settingPages/setting_about_page.dart';
import 'package:boss/pages/homePage/settingPages/setting_general_page.dart';
import 'package:boss/pages/homePage/settingPages/setting_help_page.dart';
import 'package:boss/pages/homePage/settingPages/setting_notification_page.dart';
import 'package:boss/pages/homePage/settingPages/setting_profile_page.dart';
import 'package:boss/pages/homePage/settingPages/setting_widget_page.dart';
import 'package:boss/pages/login_page.dart';
import 'package:boss/pages/tutorial_page.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

// Importa los proveedores de la aplicación
import 'package:boss/providers/apiData_provider.dart';
import 'package:boss/providers/filterDate_provider.dart';
import 'package:boss/providers/language_provider.dart';
import 'package:boss/providers/notificationItem_provider.dart';
import 'package:boss/providers/notification_provider.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/providers/user_provider.dart';

// Importa recursos adicionales
import 'package:boss/resources/dio_ssl.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

// Función principal de la aplicación
void main() async {
  // Desactiva la verificación SSL para hacer peticiones a API's sin certificado
  bypassSslVerification();
  WidgetsFlutterBinding.ensureInitialized();
  // Inicia la conexión a Firebase para recibir notificaciones en tiempo real
  await Firebase.initializeApp();
  // Inicia la app
  runApp(const MyApp());
}

// Clase principal de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        // Proveedores de notificación que deben ser compartidos en toda la aplicación
        providers: [
          ChangeNotifierProvider<ModulesProvider>(
              create: (_) => ModulesProvider()),
          ChangeNotifierProvider<RefreshProvider>(
              create: (_) => RefreshProvider()),
          ChangeNotifierProvider<DateTimeProvider>(
              create: (_) => DateTimeProvider()),
          ChangeNotifierProvider<LanguageProvider>(
              create: (_) => LanguageProvider()),
          ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
          ChangeNotifierProvider<WidgetProvider>(
              create: (_) => WidgetProvider()),
          ChangeNotifierProvider<NotificationProvider>(
              create: (_) => NotificationProvider()),
          ChangeNotifierProvider<NotificationItemProvider>(
              create: (_) => NotificationItemProvider()),
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
          ChangeNotifierProvider<ApiDataProvider>(
              create: (_) => ApiDataProvider()),
        ],
        builder: (context, _) {
          return context.watch<LanguageProvider>().languageTexts == null
              ? MaterialApp(
                  localizationsDelegates: [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                  supportedLocales: [
                      Locale('es'), // Spanish

                      // Locale('en'), // English
                    ],
                  debugShowCheckedModeBanner: false,
                  title: 'Boss',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ))
              : SkeletonTheme(
                  themeMode: ThemeMode.light,
                  shimmerGradient: themeSkeleton(context: context),
                  child: MaterialApp(
                    title: 'Flutter Demo',
                    debugShowCheckedModeBanner: false,
                    theme: themeData(context),
                    routes: {
                      // Rutas de la aplicación
                      '/home': (context) => const HomePage(),
                      '/tutorial': (context) => const TutorialPage(),
                      '/login': (context) => const LoginPage(),
                      '/filter': (context) => const FilterPage(),

                      // Paginas de configuración
                      '/config/general': (context) => const GeneralPage(),
                      '/config/widgets': (context) => const WidgetPage(),
                      '/config/notifications': (context) =>
                          const NotificationPage(),
                      '/config/profile': (context) => const ProfilePage(),
                      '/config/help': (context) => const HelpPage(),
                      '/config/about': (context) => const AboutPage(),

                      // Paginas de estadisticas generales
                      '/not/cashClosure': (context) =>
                          const NotificationCashClosurePage(),
                    },
                    initialRoute: '/login',
                  ),
                );
        });
  }
}

// Método para definir el tema de esqueleto de la aplicación
themeSkeleton({required BuildContext context}) {
  ThemeProvider watchTheme = context.watch<ThemeProvider>();

  return LinearGradient(
    colors: [
      watchTheme.colors.background,
      watchTheme.colors.primary,
      watchTheme.colors.background,
    ],
    stops: const [
      0.1,
      0.5,
      0.9,
    ],
  );
}

// Método para definir el tema de la aplicación
ThemeData themeData(BuildContext context) {
  ThemeProvider watchTheme = context.watch<ThemeProvider>();

  // Configuración de temas personalizados basados en las preferencias del usuario
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
        iconColor: watchTheme.colors.white,
        subtitleTextStyle: TextStyle(
          color: watchTheme.colors.lightPrimary,
        )),
    dividerTheme: DividerThemeData(
      color: watchTheme.colors.lightBackground,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: watchTheme.colors.background,
      //elevation: 3,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black,
      titleSpacing: 5,
    ),
    cardTheme: CardTheme(
      margin: EdgeInsets.zero,
      elevation: 5,
      color: watchTheme.colors.background,
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
      background: watchTheme.colors.backgroundAlt,
      onPrimary: watchTheme.colors.white,
    ),
    useMaterial3: true,
  );
}
