import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/routes/app_routes.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'core/bindings/controller_binder.dart';
import 'core/utils/theme/theme.dart';

class Protiva502 extends StatelessWidget {
  const Protiva502({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          navigatorKey: Get.key,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.getSplashScreen(),
          getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          // ✅ Combine EasyLoading + ZegoCloud overlay
          builder: (context, child) {
            // Step 1: Apply EasyLoading
            // final easyLoadingChild = EasyLoading.init()(context, child);

            // Step 2: Wrap with ZegoCloud overlay
            return ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () => Get.key.currentState!.context,
              // size: easyLoadingChild!!,
            );
          },
        );
      },
    );
  }
}
