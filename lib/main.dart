import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protiva502/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // Make it transparent
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          Brightness.dark, // Dark icons for light backgrounds
    ),
  );

  // If you want the app to draw behind the nav bar (True transparency)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const Protiva502());
}
