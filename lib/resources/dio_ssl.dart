import 'dart:io';

void bypassSslVerification() {
  // Desactivar verificación SSL (solo para entornos de desarrollo y pruebas)
  if (Platform.isAndroid) {
    // Para Android
    HttpOverrides.global = MyHttpOverrides();
  } else if (Platform.isIOS) {
    // Para iOS
    HttpOverrides.global = MyHttpOverrides();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
