import 'package:boss/providers/theme_provider.dart';
import 'package:boss/widgets/components/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double minScale = 1.0;
  double maxScale = 1.1;
  double baseImageSize = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(
        reverse:
            true); // Hace que la animación se repita de forma infinita y en reversa.

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider watchTheme = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: watchTheme.colors.background,
      body: Center(
        child: Container(
            child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            double scale = baseImageSize *
                (minScale + (maxScale - minScale) * _animation.value);

            // Escala que varía desde 1.0 hasta 2.0 (valor inicial + valor de la animación).
            double offsetY = 1.0 *
                _animation
                    .value; // Desplazamiento vertical que varía desde 0 hasta 100 (valor inicial + valor de la animación).

            return Transform.scale(
              scale: scale,
              child: Transform.translate(
                offset: Offset(0, offsetY),
                child: MyLogoWidget(size: 30),
              ),
            );
          },
        )),
      ),
    );
  }
}
