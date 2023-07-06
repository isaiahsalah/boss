import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/AppDimensions.dart';
import 'package:boss/widgets/components/MyComboBoxWidget.dart';
import 'package:boss/widgets/components/MyListTileGeneralWidget.dart';
import 'package:boss/widgets/components/MySwithWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

const List<String> list = <String>['Semana', 'Mes', 'Año'];

class _ProfilePageState extends State<ProfilePage> {
  bool _lights = false;
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();
    LanguageProvider readLanguage = context.read<LanguageProvider>();
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    ThemeProvider readTheme = context.read<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("subTitle",
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeXXSmall,
                  color: watchTheme.colors.lightPrimary,
                )),
            Text(watchLanguage.languageTexts!.appTitle,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeSmall,
                )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMedium),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingMedium),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyListTileGeneralWidget(
                  title: "Cambiar contraseña",
                  subtitle: "wdfsefes",
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios_rounded)),
                ),
                Divider(height: 1),
              ],
            ),
          ),
          decoration: BoxDecoration(
              color: watchTheme.colors.primary,
              borderRadius: BorderRadius.circular(AppDimensions.spacingSmall)),
        ),
      ),
    );
  }
}
