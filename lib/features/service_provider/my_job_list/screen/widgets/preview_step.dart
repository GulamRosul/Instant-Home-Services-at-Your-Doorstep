import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/service_provider/my_job_list/controller/create_job_controller.dart';

class PreviewStep extends StatelessWidget {
  const PreviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateJobController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionCard(
          title: 'Job Details',
          icon: Icons.description_outlined,
          onEdit: () => controller.currentStep.value = 0,
          children: [
            _buildDetailRow('Job Title', controller.jobTitleController.text),
            SizedBox(height: 16.h),
            _buildDetailRow(
              'Description',
              controller.jobDescriptionController.text,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _buildDetailRow(
                    'Service Category',
                    controller.selectedCategory.value,
                  ),
                ),
                Expanded(
                  child: _buildDetailRow(
                    '',
                    controller.selectedSpecificService.value,
                    isBullet: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildDetailRow('Budget', controller.priceType.value),
            Text(
              'Maximum : \$${controller.basePriceController.text}/hour',
              style: getTextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        _buildSectionCard(
          title: 'image',
          icon: Icons.image_outlined,
          showIconTitle: true,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                ImagePath.servicecard, // Mocking image from path
                width: double.infinity,
                height: 180.h,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        _buildSectionCard(
          title: 'Include in your service',
          onEdit: () => controller.currentStep.value = 1,
          children: controller.includedServices
              .map(
                (s) => Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Text(
                    s,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 24.h),
        _buildNextStepsInfo(),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    IconData? icon,
    bool showIconTitle = false,
    VoidCallback? onEdit,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20.sp, color: Colors.grey.shade600),
                SizedBox(width: 8.w),
              ],
              Text(
                title,
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              if (onEdit != null)
                GestureDetector(
                  onTap: onEdit,
                  child: Icon(
                    Icons.edit_note_rounded,
                    size: 24.sp,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBullet = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        if (label.isNotEmpty) SizedBox(height: 4.h),
        Row(
          children: [
            if (isBullet) ...[
              Container(
                width: 4.w,
                height: 4.w,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
            ],
            Expanded(
              child: Text(
                value,
                style: getTextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                  lineHeight: 1.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNextStepsInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFD0E7FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What happens next?',
            style: getTextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0050B3),
            ),
          ),
          SizedBox(height: 12.h),
          _buildInfoItem('Your job will be posted and visible to Clients'),
          _buildInfoItem('You\'ll receive quotes and proposals'),
          _buildInfoItem('Review provider profiles, ratings, and proposals'),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(fontSize: 14.sp, color: const Color(0xFF0050B3)),
          ),
          Expanded(
            child: Text(
              text,
              style: getTextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF0050B3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
