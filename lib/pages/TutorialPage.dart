import 'package:boss/providers/LanguageProvider.dart';
import 'package:boss/providers/ThemeProvider.dart';
import 'package:boss/resources/appDimensions.dart';
import 'package:boss/widgets/MyButtonWidget.dart';
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

    ThemeProvider readTheme = context.read<ThemeProvider>();
    double screenHeight = MediaQuery.of(context).size.height;

    void onPressedSkip() => {Navigator.pushNamed(context, '/login')};
    final CarouselController _carouselController = CarouselController();

    void _goToNextSlide() {
      _carouselController.nextPage();
    }

    List<Widget> _items = [
      itemCarousel(
        title: watchLanguage.languageTexts!.pages.tutorial.slides[0].title,
        subTitle:
            watchLanguage.languageTexts!.pages.tutorial.slides[0].subTitle,
        watchTheme: watchTheme,
        imageLink: "assets/images/theStrokes.jpg",
      ),
      itemCarousel(
        title: watchLanguage.languageTexts!.pages.tutorial.slides[1].title,
        subTitle:
            watchLanguage.languageTexts!.pages.tutorial.slides[1].subTitle,
        watchTheme: watchTheme,
        imageLink: "assets/images/danielQuien.jpg",
      ),
      itemCarousel(
        title: watchLanguage.languageTexts!.pages.tutorial.slides[1].title,
        subTitle:
            watchLanguage.languageTexts!.pages.tutorial.slides[1].subTitle,
        watchTheme: watchTheme,
        imageLink: "assets/images/littleJesus.jpg",
      ),
      SizedBox()
    ];

    return Scaffold(
      body: SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.spacingMedium),
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
                      carouselController: _carouselController,
                      items: _items,
                      options: CarouselOptions(
                        height: 380,
                        enlargeCenterPage: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                        aspectRatio: 5 / 4,
                        onPageChanged: (index, reason) {
                          if (index == _items.length - 1) {
                            Navigator.pushNamed(context, '/login');
                          }
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.spacingMedium),
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
                        SizedBox(
                          height: AppDimensions.spacingSmall,
                        ),
                        Row(
                          children: [
                            MyButtonWidget(
                              text: watchLanguage
                                  .languageTexts!.pages.tutorial.button.bottom,
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
          style: TextStyle(
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
        SizedBox(height: 20),
        Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            color: watchTheme.colors.lightBackground,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(500),
            child: Image.asset(
              width: 200,
              height: 200,
              imageLink,
              fit: BoxFit.contain,
            ),
          ),
          //Image.asset("assets/images/corbata.png", height: 150),
        ),
      ],
    ),
  );
}
