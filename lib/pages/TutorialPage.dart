// ignore_for_file: file_names

import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/appDimensions.dart';
import 'package:boss/widgets/MyButtonWidget.dart';
import 'package:boss/widgets/components/MyComboBoxWidget.dart';
import 'package:boss/widgets/components/MyLogoTextWidget.dart';
import 'package:boss/widgets/components/MyLogoWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();
    LanguageProvider watchLanguage = context.watch<LanguageProvider>();
    LanguageProvider readLanguage = context.read<LanguageProvider>();

    double screenHeight = MediaQuery.of(context).size.height;

    void onPressedSkip() => Navigator.pushNamed(context, '/login');
    final CarouselController carouselController = CarouselController();

    // ignore: no_leading_underscores_for_local_identifiers
    void _goToNextSlide() {
      carouselController.nextPage();
    }

    List<Widget> items = [
      itemCarousel(
        title: watchLanguage.languageTexts!.pages.tutorial.slides[0].title,
        subTitle:
            watchLanguage.languageTexts!.pages.tutorial.slides[0].subTitle,
        watchTheme: watchTheme,
        imageLink: "assets/images/report.png",
      ),
      itemCarousel(
        title: watchLanguage.languageTexts!.pages.tutorial.slides[1].title,
        subTitle:
            watchLanguage.languageTexts!.pages.tutorial.slides[1].subTitle,
        watchTheme: watchTheme,
        imageLink: "assets/images/seo.png",
      ),
      itemCarousel(
        title: watchLanguage.languageTexts!.pages.tutorial.slides[1].title,
        subTitle:
            watchLanguage.languageTexts!.pages.tutorial.slides[1].subTitle,
        watchTheme: watchTheme,
        imageLink: "assets/images/project.png",
      ),
      const SizedBox()
    ];

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    watchTheme.colors.primary,
                    watchTheme.colors.background,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Container(
                  constraints:
                      BoxConstraints(maxWidth: 400.0, minHeight: screenHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(AppDimensions.spacingMedium),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyLogoWidget(size: 20),
                            SizedBox(
                              width: AppDimensions.spacingSmall,
                            ),
                            MyLogoTextWidget(
                              size: 20,
                            )
                          ],
                        ),
                      ),
                      CarouselSlider(
                          carouselController: carouselController,
                          items: items,
                          options: CarouselOptions(
                            height: 400,
                            enlargeCenterPage: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: false,
                            viewportFraction: 1,
                            aspectRatio: 5 / 4,
                            onPageChanged: (index, reason) {
                              if (index == items.length - 1) {
                                Navigator.pushNamed(context, '/login');
                              }
                            },
                          )),
                      Padding(
                        padding:
                            const EdgeInsets.all(AppDimensions.spacingMedium),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                MyButtonWidget(
                                  text: watchLanguage
                                      .languageTexts!.pages.tutorial.button.top,
                                  onPressed: _goToNextSlide,
                                  color: watchTheme.colors.active,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: AppDimensions.spacingSmall,
                            ),
                            Row(
                              children: [
                                MyButtonWidget(
                                  text: watchLanguage.languageTexts!.pages
                                      .tutorial.button.bottom,
                                  onPressed: onPressedSkip,
                                  color: watchTheme.colors.lightBackground,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.spacingLong),
              child: MyComboBoxWidget(
                listData: watchLanguage.listLanguage,
                dropdownValue: watchLanguage.dropdownValue,
                onChange: (String? value) {
                  readLanguage.languageChange(lang: value!);

                  /*setState(() {
                                dropdownValue = value!;
                              });*/
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget itemCarousel({
  required String title,
  required String subTitle,
  required ThemeProvider watchTheme,
  required String imageLink,
}) {
  return Padding(
    padding:
        const EdgeInsets.symmetric(horizontal: AppDimensions.spacingMedium),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: AppDimensions.fontSizeMedium,
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(
              fontSize: AppDimensions.fontSizeXSmall,
              color: watchTheme.colors.lightPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
          ),
          child: Image.asset(
            width: 200,
            height: 200,
            imageLink,
            fit: BoxFit.contain,
          ),
          //Image.asset("assets/images/corbata.png", height: 150),
        ),
      ],
    ),
  );
}
