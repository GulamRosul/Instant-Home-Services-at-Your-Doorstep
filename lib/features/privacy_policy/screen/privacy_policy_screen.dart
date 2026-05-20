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

        final policy = controller.privacyPolicy.value;
        if (policy == null) {
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

    // Remove paragraphs that contain only &nbsp; or whitespace
    html = html.replaceAll(
      RegExp(
        r'<p[^>]*>\s*(<b[^>]*>)?\s*(&nbsp;)?\s*(</b>)?\s*</p>',
        dotAll: true,
      ),
      '',
    );

    // Remove standalone <br> tags
    html = html.replaceAll(RegExp(r'<br\s*/?>'), '');

    return html;
  }
}
