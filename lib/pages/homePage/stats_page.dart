// ignore_for_file: file_names

import 'package:boss/api/user_api.dart';
import 'package:boss/constants/api_const.dart';
import 'package:boss/models/module_model.dart';
import 'package:boss/pages/homePage/statPages/stat_template_page.dart';
import 'package:boss/providers/language_provider.dart';
import 'package:boss/providers/modules_provider.dart';
import 'package:boss/providers/theme_provider.dart';
import 'package:boss/providers/user_provider.dart';
import 'package:boss/resources/resources.dart';
import 'package:boss/widgets/main/listTile_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_Card_widget.dart';
import 'package:boss/widgets/skeleton/skeleton_menu_widget.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  late Future<List<ModuleModel>> listModule;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listModule = loadList(
        token: Provider.of<UserProvider>(context, listen: false).user!.token);
  }

  Future<List<ModuleModel>> loadList({required String token}) async {
    Response<dynamic> responseModules = await apiModuleList(
      authToken: token,
      context: context,
    );

    //= moduleModelFromJson(responseModules.data);
    return moduleModelFromJson(responseModules.data);
    /*readModules.setListModules(
        listModules: moduleModelFromJson(responseModules.data));*/
  }

  @override
  Widget build(BuildContext context) {
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    UserProvider watchUser = context.watch<UserProvider>();

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<List<ModuleModel>>(
          future: listModule,
          builder: (BuildContext context,
              AsyncSnapshot<List<ModuleModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SkeletonMenuWidget();
            } else if (snapshot.hasError) {
              return Text('Error al cargar los datos: ${snapshot.error}');
            } else {
              //watchLanguage.languageTexts!.pages.stats.items
              //return SkeletonMenuWidget();
              return ListView(
                padding: const EdgeInsets.all(AppDimensions.spacingMedium),
                children: snapshot.data!
                    .mapIndexed(
                      (i, item) => Column(
                        children: [
                          MyListTile(
                            title: item.nombre,
                            subTitle: 'Módulo ${item.nombre}',
                            leading: Image.network(
                              '${ApiConst.baseUrl}${item.img}',
                              color: watchTheme.colors.white,
                              height: 24,
                              alignment: Alignment.center,
                            ),
                            //AppData.myListMenuStats[i]["leading"],

                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                            onPressed: () async {
                              /*  Navigator.pushNamed(
                            context,
                            AppData.myListMenuStats[i]["onPressed"],
                          );*/

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StatTemplatePage(moduleData: item),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 12,
                          )
                        ],
                      ),
                    )
                    .toList(),
              );
            }
          },
        ));
  }
}
