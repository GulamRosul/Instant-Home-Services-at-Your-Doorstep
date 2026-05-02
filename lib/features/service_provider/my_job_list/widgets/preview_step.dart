import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/icon_path.dart';
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
          title: 'job_details'.tr,
          icon: Icons.description_outlined,
          onEdit: () => controller.currentStep.value = 0,
          children: [
            _buildLabel('job_title'.tr),
            SizedBox(height: 12.h),
            Text(
              controller.jobTitleController.text,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF2D2D2D),
              ),
            ),
            SizedBox(height: 8.h),
            const Divider(color: Color(0xFFE2E8F0)),
            SizedBox(height: 16.h),
            _buildLabel('job_description'.tr),
            SizedBox(height: 12.h),
            Text(
              controller.jobDescriptionController.text,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF2D2D2D),
                lineHeight: 1.5,
              ),
            ),
            SizedBox(height: 16.h),
            _buildLabel('service_category'.tr),
            SizedBox(height: 12.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: const Color(0xFFD9D9D9)),
                  ),
                  child: Text(
                    controller.selectedCategory.value,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
                Container(
                  width: 3.w,
                  height: 3.w,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  controller.selectedSpecificService.value,
                  style: getTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            _buildLabel('budget'.tr),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: const Color(0xFFD9D9D9)),
              ),
              child: Text(
                controller.priceType.value,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF2D2D2D),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              '${'minimum'.tr} : ৳ ${controller.basePriceController.text}/hour',
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF2D2D2D),
              ),
            ),
          ],
        ),

        SizedBox(height: 20.h),
        Obx(
          () => _buildSectionCard(
            title: 'image'.tr,
            icon: Icons.image_outlined,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: controller.uploadedImagePath.value.isNotEmpty
                    ? Image.file(
                        File(controller.uploadedImagePath.value),
                        width: double.infinity,
                        height: 180.h,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: double.infinity,
                        height: 180.h,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.image,
                          size: 50.sp,
                          color: Colors.grey,
                        ),
                      ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Text(
                    'included_service'.tr,
                    style: getTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF09090B),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => controller.currentStep.value = 1,
                    child: SvgPicture.asset(
                      IconPath.edit,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              ...controller.includedServices.map(
                (s) => Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Text(
                    s,
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        _buildNextStepsInfo(),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    IconData? icon,
    VoidCallback? onEdit,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFD9D9D9)),
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
                Icon(icon, size: 20.sp, color: const Color(0xFF2D2D2D)),
                SizedBox(width: 8.w),
              ],
              Text(
                title,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2D2D2D),
                ),
              ),
              const Spacer(),
              if (onEdit != null)
                GestureDetector(
                  onTap: onEdit,
                  child: SvgPicture.asset(
                    IconPath.edit,
                    height: 20.h,
                    width: 20.w,
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: getTextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF2D2D2D),
      ),
    );
  }

  Widget _buildNextStepsInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF6FAFF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'what_happens_next'.tr,
            style: getTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF1D4ED8),
            ),
          ),
          SizedBox(height: 10.h),
          _buildInfoItem('your_job_will_be_posted'.tr),
          _buildInfoItem('you_ll_receive_quotes'.tr),
          _buildInfoItem('review_provider_profiles'.tr),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: TextStyle(fontSize: 14.sp, color: Color(0xFF2D2D2D)),
        ),
        Expanded(
          child: Text(
            text,
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF2D2D2D),
            ),
          ),
        ),
      ],
    );
  }
}
