// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:boss/api/user_api.dart';
import 'package:boss/constants/prefs_const.dart';
import 'package:boss/models/module_model.dart';
import 'package:boss/models/user_model.dart';
import 'package:boss/models/widgets/widget_model.dart';
import 'package:boss/pages/loading_page.dart';
import 'package:boss/providers/language_provider.dart';
import 'package:boss/providers/modules_provider.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/providers/user_provider.dart';
import 'package:boss/resources/dimensions_resource.dart';
import 'package:boss/widgets/button_widget.dart';
import 'package:boss/widgets/components/logoSingletonText_widget.dart';
import 'package:boss/widgets/components/logoSingleton_widget.dart';
import 'package:boss/widgets/components/logoText_widget.dart';
import 'package:boss/widgets/components/logo_widget.dart';
import 'package:dio/dio.dart';
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
  final Future<SharedPreferences> _prefsFuture =
      SharedPreferences.getInstance();
  late Future<String> _user;
  //late bool verifyJwt;
  late UserModel user;
  late List<ModuleModel> listModule;

  //late SharedPreferences prefsGnt;

  late List<WidgetModel> listaWidget;
  @override
  void initState() {
    super.initState();

    _user = _prefsFuture.then((SharedPreferences prefs) async {
      //prefsGnt = await SharedPreferences.getInstance();
      //print(prefs.getString(PrefsConstants.prefsUser));
      if ((prefs.getString(PrefsConstants.prefsUser) ?? "") != "") {
        user = userModelFromJson(prefs.getString(PrefsConstants.prefsUser)!);

        /*verifyJwt = await apiVerifyJwtToken(user.token);
        if (verifyJwt) {
          if ((prefs.getString(PrefsConstants.prefsWidgets) ?? "") != "") {
            listaWidget = widgetModelFromJson(
                prefs.getString(PrefsConstants.prefsWidgets)!);
          } else {
            dynamic listWidgetsJSON = await apiWidget(user);
            if (listWidgetsJSON != null) {
              listaWidget = listWidgetsJSON;
            }
          }
        }*/
      }
      return prefs.getString(PrefsConstants.prefsUser) ?? "";
    });
  }

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
    //UserProvider watchUser = context.watch<UserProvider>();
    UserProvider readUser = context.read<UserProvider>();
    ModulesProvider readModules = context.read<ModulesProvider>();

    double screenHeight = MediaQuery.of(context).size.height;

    void savePrefs({
      required Response<dynamic> response,
      required SharedPreferences prefsGnt,
    }) async {
      readUser.userChange(user: userModelFromJson(response.data));
/*
      Response<dynamic> responseModules = await apiModuleList(
        authToken: readUser.user!.token,
      );

      //print(responseModules.data);

      readModules.setListModules(
          listModules: moduleModelFromJson(responseModules.data));
*/

      prefsGnt.setString('user', userModelToJson(readUser.user!));
      print(response.data);
      Navigator.pushNamed(context, '/home');
    }

    void onPressedLogin() async {
      if (textUserController.text == "" || textPassController.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No dejes espacios en blanco'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                // Code to execute.
              },
            ),
          ),
        );
        return;
      }

      Response<dynamic> response =
          await apiUserLogin(textUserController.text, textPassController.text);

      SharedPreferences prefsGnt = await SharedPreferences.getInstance();

      switch (response.statusCode) {
        case 401:
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
          break;
        case 400:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Usuario sin empresa'),
              action: SnackBarAction(
                label: 'Ok',
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
          break;
        case 500:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error de servidor'),
              action: SnackBarAction(
                label: 'Ok',
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
          break;

        case 200:
          if (jsonDecode(response.data)["Empresas"] != null) {
            //print(jsonDecode(response)["Empresas"][0]);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  titlePadding: const EdgeInsets.only(
                    right: AppDimensions.spacingMedium,
                    left: AppDimensions.spacingMedium,
                    top: AppDimensions.spacingMedium,
                    bottom: AppDimensions.spacingSmall,
                  ),
                  contentPadding: const EdgeInsets.only(
                    right: AppDimensions.spacingMedium,
                    left: AppDimensions.spacingMedium,
                    bottom: AppDimensions.spacingMedium,
                  ),
                  actionsPadding:
                      const EdgeInsets.all(AppDimensions.spacingSmall),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions
                        .radiusSmall), // Modifica el radio de borde aquí
                  ),
                  backgroundColor: watchTheme.colors.background,
                  surfaceTintColor: Colors.transparent,
                  contentTextStyle: const TextStyle(),
                  titleTextStyle: const TextStyle(),
                  title: Column(
                    children: [
                      Text(
                        "Escoge tu empresa",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: AppDimensions.fontSizeSmall),
                      ),
                      Divider()
                    ],
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: jsonDecode(response.data)["Empresas"]
                          .map<Widget>((empresa) {
                        return ListTile(
                            title: Text(
                              empresa["Nombre"],
                              textAlign: TextAlign.center,
                            ),
                            onTap: () async {
                              Response<dynamic> responseEnterprise =
                                  await apiUserEnterprise(
                                authToken: jsonDecode(response.data)["Token"],
                                idEnterprise: empresa["Id"],
                              );
                              savePrefs(
                                  prefsGnt: prefsGnt,
                                  response: responseEnterprise);
                            });
                      }).toList(),
                    ),
                  ),
                );
              },
            );
            //print(response);
          } else {
            savePrefs(prefsGnt: prefsGnt, response: response);
          }
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error desconocido'),
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

    Widget content(
        {required ThemeProvider watchTheme,
        required LanguageProvider watchLanguage,
        required double screenHeight,
        required UserProvider readUser}) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  watchTheme.colors.background,
                  watchTheme.colors.backgroundAlt
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingMedium),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(AppDimensions.spacingMedium),
                    constraints: BoxConstraints(
                        maxWidth: 400.0, minHeight: screenHeight),
                    child: const MyLogoSingletonTextWidget(size: 45),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MyLogoWidget(size: 45),
                      const MyLogoTextWidget(size: 20),
                      const SizedBox(height: AppDimensions.spacingLong * 2),
                      mytextFieldUser(
                        user: textUserController,
                        watchTheme: watchTheme,
                        watchLanguage: watchLanguage,
                      ),
                      const SizedBox(height: 12),
                      mytextFieldPass(
                        pass: textPassController,
                        watchTheme: watchTheme,
                        watchLanguage: watchLanguage,
                      ),
                      const SizedBox(height: AppDimensions.spacingLong * 2),
                      Row(
                        children: [
                          MyButtonWidget(
                            text:
                                watchLanguage.languageTexts!.pages.login.button,
                            onPressed: () {
                              onPressedLogin();
                            },
                            color: watchTheme.colors.active,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return FutureBuilder(
        future: _user,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return LoadingPage();
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (snapshot.data != "") {
                //if (verifyJwt == true) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  //readWidget.listWidgetsChange(listaWidget);
                  readUser.userChange(user: user);

                  Navigator.pushReplacementNamed(context, '/home');
                });
                return LoadingPage();
                //}
              }
              return content(
                  readUser: readUser,
                  screenHeight: screenHeight,
                  watchLanguage: watchLanguage,
                  watchTheme: watchTheme);
          }
        });
  }

  /*
void selectEnterprise(
        {required dynamic empresa, required Response<dynamic> response}) async {
      Response<dynamic> responseEnterprise = await apiUserEnterprise(
          authToken: empresa["Id"],
          idEnterprise: jsonDecode(response.data)["Token"]);

      switch (responseEnterprise.statusCode) {
        case 401:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Token invalido'),
              action: SnackBarAction(
                label: 'Ok',
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
          break;

        case 500:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error del servidor'),
              action: SnackBarAction(
                label: 'Ok',
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
          break;
        case 200:
          readUser.userChange(user: userModelFromJson(responseEnterprise.data));
          prefs.setString('user', userModelToJson(readUser.user!));

          //print(userModelToJson(readUser.user!));

          /*dynamic listWidgetsJSON = await apiWidget(userModelFromJson(response));
                        if (listWidgetsJSON != null) {
                        readWidget.listWidgetsChange(listWidgetsJSON);
                      }*/
          Navigator.pushNamed(context, '/home');
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error deconocido'),
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

    */

  Widget mytextFieldUser({
    required ThemeProvider watchTheme,
    required LanguageProvider watchLanguage,
    required TextEditingController user,
  }) {
    return CupertinoTextField(
      onSubmitted: (value) {},
      decoration: BoxDecoration(
        color: watchTheme.colors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: const Offset(
              0.0,
              2.0,
            ), // Desplazamiento de la sombra en el eje X y Y
          ),
        ],
      ),
      controller: user,
      cursorColor: watchTheme.colors.lightPrimary,
      placeholderStyle: TextStyle(
        color: watchTheme.colors.lightPrimary,
      ),
      style: TextStyle(
        color: watchTheme.colors.white,
        fontSize: AppDimensions.fontSizeSmall,
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
  }) {
    return CupertinoTextField(
      onSubmitted: (value) {},
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
        color: watchTheme.colors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: const Offset(
              0.0,
              2.0,
            ), // Desplazamiento de la sombra en el eje X y Y
          ),
        ],
      ),
      placeholder: watchLanguage.languageTexts!.pages.login.passwordPlaceholder,
      padding: const EdgeInsets.all(AppDimensions.spacingSmall),
      textAlign: TextAlign.center,
    );
  }
}
