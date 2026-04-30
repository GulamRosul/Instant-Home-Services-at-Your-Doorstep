import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/routes/app_routes.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'core/bindings/controller_binder.dart';
import 'core/utils/theme/theme.dart';

// ✅ Global navigator key shared between GetX and ZegoCloud
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
          navigatorKey: appNavigatorKey, // ✅ use shared key
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.getSplashScreen(),
          getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          // builder: (context, child) {
          //   Widget widget =
          //       EasyLoading.init()(context, child) ?? const SizedBox.shrink();

          //   widget = Stack(
          //     children: [
          //       widget,
          //       ZegoUIKitPrebuiltCallMiniOverlayPage(
          //         contextQuery: () {
          //           final state = appNavigatorKey.currentState;
          //           final overlay = state?.overlay;
          //           if (overlay != null) {
          //             return overlay.context;
          //           }
          //           return context;
          //         },
          //       ),
          //     ],
          //   );

          //   return widget;
          // },
          builder: (context, child) {
            Widget widget =
                EasyLoading.init()(context, child) ?? const SizedBox.shrink();

            return Stack(
              children: [
                widget,
                ZegoUIKitPrebuiltCallMiniOverlayPage(
                  // ✅ Use context directly from builder — always valid
                  contextQuery: () => context,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
