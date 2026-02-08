import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart'; // Adjust path
import 'package:protiva502/core/common/widgets/custom_appbar.dart'; // Adjust path
// Adjust path

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Subtle grey background from UI
      appBar: const CustomAppBar(title: 'Privacy & Policy'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE2E8F0)), // Light slate border
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy Policy",
                style: getTextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Last updated: February 7, 2026",
                style: getTextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: 24.h),
              
              _buildPolicySection(
                "1. Information We Collect",
                "We collect information you provide directly to us, such as when you create an account, update your profile, or communicate with us. This may include your name, email address, phone number, and payment information.",
              ),
              
              _buildPolicySection(
                "2. How We Use Your Information",
                "We use the information we collect to provide, maintain, and improve our services, to process your transactions, to send you related information, and to monitor and analyze trends, usage, and activities in connection with our services.",
              ),
              
              _buildPolicySection(
                "3. Sharing of Information",
                "We may share your information with third-party vendors, consultants, and other service providers who need access to such information to carry out work on our behalf. We may also share information if we believe your actions are inconsistent with our user agreements or policies.",
              ),
              
              _buildPolicySection(
                "4. Data Security",
                "We take reasonable measures to help protect information about you from loss, theft, misuse and unauthorized access, disclosure, alteration and destruction.",
              ),
              
              _buildPolicySection(
                "5. Contact Us",
                "If you have any questions about this Privacy Policy, please contact us at support@example.com.",
              ),
              
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getTextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            content,
            textAlign: TextAlign.justify,
            style: getTextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF475569), // Slate-600 for readability
              lineHeight: 20.sp, // Ensuring enough spacing for body text
            ),
          ),
        ],
      ),
    );
  }
}