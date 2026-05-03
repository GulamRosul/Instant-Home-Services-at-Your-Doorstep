import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/localization/localization_service.dart';
import 'package:protiva502/core/utils/theme/app_system_theme.dart';
import 'package:protiva502/routes/app_routes.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'core/bindings/controller_binder.dart';
import 'core/utils/theme/theme.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

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
          navigatorKey: appNavigatorKey,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.getSplashScreen(),
          getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          locale: LocalizationService.currentLocale,
          fallbackLocale: LocalizationService.fallbackLocale,
          translations: LocalizationService(),
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          builder: (context, child) {
            /// ✅ Get System UI style from theme
            final overlayStyle = Theme.of(context)
                .extension<AppSystemTheme>()!
                .systemOverlayStyle;

            /// ✅ Keep EasyLoading
            final easyLoaded = EasyLoading.init()(context, child);

            /// ✅ Final UI stack
            final content = Stack(
              children: [
                easyLoaded,
                ZegoUIKitPrebuiltCallMiniOverlayPage(
                  contextQuery: () =>
                      appNavigatorKey.currentState?.overlay?.context ?? context,
                ),
              ],
            );

            /// ✅ Apply System UI globally
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: overlayStyle,
              child: content,
            );
          },
        );
      },
    );
  }
}