import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protiva502/app.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       systemNavigationBarColor: Colors.transparent,
//       systemNavigationBarDividerColor: Colors.transparent,
//       // This line makes the icons visible (dark) on a light background
//       systemNavigationBarIconBrightness: Brightness.dark,
//       systemNavigationBarContrastEnforced: false,

//       // Do the same for the status bar at the top
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//     ),
//   );

//   SystemChrome.setEnabledSystemUIMode(
//     SystemUiMode.manual,
//     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
//   );

//   runApp(const Protiva502());
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // A very light grey/off-white background
      systemNavigationBarColor: Color(0xFFF8FAFC), 
      systemNavigationBarDividerColor: Colors.transparent,
      
      // Use dark icons (black). 
      // Against the F8FAFC background, they appear greyish.
      systemNavigationBarIconBrightness: Brightness.dark,
      
      // MUST be false to avoid the system's "protection" (black bar)
      systemNavigationBarContrastEnforced: false, 
      
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const Protiva502());
}
