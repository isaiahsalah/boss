import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/MyButtonWidget.dart';
import 'package:boss/widgets/components/MyLogoTextWidget.dart';
import 'package:boss/widgets/components/MyLogoWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();

    double screenHeight = MediaQuery.of(context).size.height;

    TextEditingController _textUserController = TextEditingController();
    TextEditingController _textPassController = TextEditingController();

    void onPressedLogin() => {
          if (_textUserController.text == "nat" &&
              _textPassController.text == "dud")
            {Navigator.pushNamed(context, '/dud')}
          else
            {Navigator.pushNamed(context, '/home')}
        };

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [watchTheme.colors.primary, watchTheme.colors.background],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(AppDimensions.spacingMedium),
              constraints:
                  BoxConstraints(maxWidth: 400.0, minHeight: screenHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyLogoWidget(size: 55),
                  MyLogoTextWidget(size: 25),
                  SizedBox(height: AppDimensions.spacingLong),
                  MytextFieldUser(
                      user: _textUserController,
                      watchTheme: watchTheme,
                      watchLanguage: watchLanguage),
                  SizedBox(height: 12),
                  MytextFieldPass(
                      pass: _textPassController,
                      watchTheme: watchTheme,
                      watchLanguage: watchLanguage),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      watchLanguage.languageTexts!.pages.login.recoverPassword,
                      style: TextStyle(
                        color: watchTheme.colors.lightPrimary,
                        decoration: TextDecoration.underline,
                        fontSize: AppDimensions.fontSizeXXSmall,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimensions.spacingLong),
                  Row(
                    children: [
                      MyButtonWidget(
                        text: watchLanguage.languageTexts!.pages.login.button,
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

Widget MytextFieldUser({
  required ThemeProvider watchTheme,
  required LanguageProvider watchLanguage,
  required TextEditingController user,
}) {
  return CupertinoTextField(
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

Widget MytextFieldPass({
  required ThemeProvider watchTheme,
  required LanguageProvider watchLanguage,
  required TextEditingController pass,
}) {
  return CupertinoTextField(
    controller: pass,
    obscureText: true,
    cursorColor: watchTheme.colors.lightPrimary,
    placeholderStyle: TextStyle(
      color: watchTheme.colors.lightPrimary,
    ),
    style: TextStyle(
        color: watchTheme.colors.white, fontSize: AppDimensions.fontSizeSmall),
    decoration: BoxDecoration(
      color: watchTheme.colors.lightBackground,
      borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
    ),
    placeholder: watchLanguage.languageTexts!.pages.login.passwordPlaceholder,
    padding: const EdgeInsets.all(AppDimensions.spacingSmall),
    textAlign: TextAlign.center,
  );
}
