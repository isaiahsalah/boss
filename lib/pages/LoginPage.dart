// ignore_for_file: file_names

import 'package:boss/models/UserModel.dart';
import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/providers/UserProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/MyButtonWidget.dart';
import 'package:boss/widgets/components/MyLogoTextWidget.dart';
import 'package:boss/widgets/components/MyLogoWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final textUserController = TextEditingController();
  final textPassController = TextEditingController();
  //late SharedPreferences prefs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _userName;

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final String userName = (prefs.getString('username') ?? "");

    setState(() {
      _userName = prefs.setString('username', userName).then((bool success) {
        return userName;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _userName = _prefs.then((SharedPreferences prefs) {
      return prefs.getString('username') ?? "";
    });
  }
/*
  void obtenerDatosInicioSesion() async {
    prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    if (savedUsername == null) {
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerDatosInicioSesion();
  }*/

  @override
  void dispose() {
    textUserController.dispose();
    textPassController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();
    UserProvider watchUser = context.watch<UserProvider>();
    UserProvider readUser = context.read<UserProvider>();

    double screenHeight = MediaQuery.of(context).size.height;

    onPressedLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.setString('nombre', 'John Doe');
      if (textUserController.text == "singleton" &&
          textPassController.text == "boss") {
        prefs.setString('username', 'ejemplo@gmail.com');
        prefs.setString('token', 'token_de_acceso');
        readUser.UserChange(
            user: UserModel(
          name: "name",
          lastName: "lastName",
          userName: textUserController.text,
        ));
        Navigator.pushNamed(context, '/home');
      } else {
        //Navigator.pushNamed(context, '/home'),
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Usuario o contraseña incorrectos'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                // Code to execute.
              },
            ),
          ),
        );
      }
    }

    return FutureBuilder(
        future: _userName,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Scaffold(
                backgroundColor: watchTheme.colors.background,
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data != "") {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, '/home');
                });
                return Scaffold(
                  backgroundColor: watchTheme.colors.background,
                );
              } else {
                {
                  return Scaffold(
                    body: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              watchTheme.colors.primary,
                              watchTheme.colors.background
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(
                                AppDimensions.spacingMedium),
                            constraints: BoxConstraints(
                                maxWidth: 400.0, minHeight: screenHeight),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const MyLogoWidget(size: 45),
                                const MyLogoTextWidget(size: 20),
                                const SizedBox(
                                    height: AppDimensions.spacingLong),
                                mytextFieldUser(
                                  user: textUserController,
                                  watchTheme: watchTheme,
                                  watchLanguage: watchLanguage,
                                  onPressedLogin: onPressedLogin,
                                ),
                                const SizedBox(height: 12),
                                mytextFieldPass(
                                  pass: textPassController,
                                  watchTheme: watchTheme,
                                  watchLanguage: watchLanguage,
                                  onPressedLogin: onPressedLogin,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      watchLanguage.languageTexts!.pages.login
                                          .recoverPassword,
                                      style: TextStyle(
                                        color: watchTheme.colors.lightPrimary,
                                        decoration: TextDecoration.underline,
                                        fontSize: AppDimensions.fontSizeXXSmall,
                                        //decorationThickness: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    height: AppDimensions.spacingLong),
                                Row(
                                  children: [
                                    MyButtonWidget(
                                      text: watchLanguage
                                          .languageTexts!.pages.login.button,
                                      onPressed: onPressedLogin,
                                      color: watchTheme.colors.active,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }
          }
        });
  }

  Widget mytextFieldUser({
    required ThemeProvider watchTheme,
    required LanguageProvider watchLanguage,
    required TextEditingController user,
    required Function onPressedLogin,
  }) {
    return CupertinoTextField(
      onSubmitted: (value) {
        onPressedLogin();
      },
      controller: user,
      cursorColor: watchTheme.colors.lightPrimary,
      placeholderStyle: TextStyle(
        color: watchTheme.colors.lightPrimary,
      ),
      style: TextStyle(
        color: watchTheme.colors.white,
        fontSize: AppDimensions.fontSizeSmall,
      ),
      decoration: BoxDecoration(
        color: watchTheme.colors.lightBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
      placeholder: watchLanguage.languageTexts!.pages.login.userPlaceholder,
      padding: const EdgeInsets.all(AppDimensions.spacingSmall),
      textAlign: TextAlign.center,
    );
  }

  Widget mytextFieldPass({
    required ThemeProvider watchTheme,
    required LanguageProvider watchLanguage,
    required TextEditingController pass,
    required Function onPressedLogin,
  }) {
    return CupertinoTextField(
      onSubmitted: (value) {
        onPressedLogin();
      },
      controller: pass,
      obscureText: true,
      cursorColor: watchTheme.colors.lightPrimary,
      placeholderStyle: TextStyle(
        color: watchTheme.colors.lightPrimary,
      ),
      style: TextStyle(
          color: watchTheme.colors.white,
          fontSize: AppDimensions.fontSizeSmall),
      decoration: BoxDecoration(
        color: watchTheme.colors.lightBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
      placeholder: watchLanguage.languageTexts!.pages.login.passwordPlaceholder,
      padding: const EdgeInsets.all(AppDimensions.spacingSmall),
      textAlign: TextAlign.center,
    );
  }
}
