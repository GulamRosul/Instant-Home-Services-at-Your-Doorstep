import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/features/privacy_policy/controller/privacy_policy_controller.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrivacyPolicyController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(title: 'privacy_policy'.tr, showBackButton: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final policy = controller.privacyPolicy.value;
        if (policy == null) {
          if (controller.error.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   'Error: ${controller.error.value}',
                  //   style: getTextStyle(fontSize: 14.sp, color: Colors.red),
                  //   textAlign: TextAlign.center,
                  // ),
                  // SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: controller.fetchPrivacyPolicy,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Text(
              'no_privacy_policy'.tr,
              style: getTextStyle(fontSize: 14.sp),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${'last_updated'.tr} : ${policy.updatedAt.toString().split(' ')[0]}",
                      style: getTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Html(
                      data: _cleanHtml(
                        policy.content,
                      ), // ✅ sanitize before rendering
                      shrinkWrap: true,
                      style: {
                        "html": Style(
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero,
                        ),
                        "body": Style(
                          fontSize: FontSize(13.sp),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF475569),
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero,
                        ),
                        "p": Style(
                          fontSize: FontSize(13.sp),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF475569),
                          lineHeight: LineHeight(1.4),
                          margin: Margins(bottom: Margin(8.h)),
                          padding: HtmlPaddings.zero,
                        ),
                        "h2": Style(
                          margin: Margins(
                            top: Margin(12.h),
                            bottom: Margin(6.h),
                          ),
                          padding: HtmlPaddings.zero,
                          fontSize: FontSize(15.sp),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        "h3": Style(
                          margin: Margins(
                            top: Margin(10.h),
                            bottom: Margin(4.h),
                          ),
                          padding: HtmlPaddings.zero,
                        ),
                        "div": Style(
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero,
                        ),
                        "ul": Style(
                          margin: Margins(
                            top: Margin(4.h),
                            bottom: Margin(8.h),
                          ),
                          padding: HtmlPaddings(left: HtmlPadding(20.w)),
                        ),
                        "li": Style(
                          fontSize: FontSize(13.sp),
                          color: const Color(0xFF475569),
                          margin: Margins(bottom: Margin(4.h)),
                        ),
                        "br": Style(display: Display.none),
                        "hr": Style(
                          margin: Margins(
                            top: Margin(16.h),
                            bottom: Margin(16.h),
                          ),
                        ),
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        );
      }),
    );
  }

  // Add this helper anywhere (top of file or in a utils file)
  String _cleanHtml(String html) {
    // Remove all inline style attributes
    html = html.replaceAll(RegExp(r'\sstyle="[^"]*"'), '');

    // Remove <o:p> tags (MS Word artifacts)
    html = html.replaceAll(RegExp(r'<o:p[^>]*>.*?</o:p>', dotAll: true), '');

    // Remove <br> and replace &nbsp; with a standard space
    html = html.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '');
    html = html.replaceAll('&nbsp;', ' ');

    // Replace newlines and carriage returns with spaces to prevent empty text node height issues
    html = html.replaceAll('\n', ' ');
    html = html.replaceAll('\r', ' ');

    // Remove alignment attributes that can cause flutter_html to expand views incorrectly
    html = html.replaceAll(RegExp(r'\salign="[^"]*"', caseSensitive: false), '');

    // Strip all attributes from <hr> to prevent massive height bugs (e.g., size="2" misinterpreted)
    html = html.replaceAll(RegExp(r'<hr[^>]*>', caseSensitive: false), '<hr>');

    // Iteratively remove completely empty structural tags
    bool changed = true;
    while (changed) {
      String newHtml = html
          .replaceAll(RegExp(r'<p[^>]*>\s*</p>', caseSensitive: false), '')
          .replaceAll(RegExp(r'<div[^>]*>\s*</div>', caseSensitive: false), '')
          .replaceAll(RegExp(r'<ul[^>]*>\s*</ul>', caseSensitive: false), '')
          .replaceAll(RegExp(r'<li[^>]*>\s*</li>', caseSensitive: false), '')
          .replaceAll(RegExp(r'<span[^>]*>\s*</span>', caseSensitive: false), '');
      if (newHtml == html) {
        changed = false;
      }
      html = newHtml;
    }

    return html;
  }
}
