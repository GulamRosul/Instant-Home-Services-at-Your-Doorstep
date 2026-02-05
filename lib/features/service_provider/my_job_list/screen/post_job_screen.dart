import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/features/service_provider/my_job_list/controller/create_job_controller.dart';
import 'package:protiva502/features/service_provider/my_job_list/screen/widgets/job_details_step.dart';
import 'package:protiva502/features/service_provider/my_job_list/screen/widgets/service_details_step.dart';
import 'package:protiva502/features/service_provider/my_job_list/screen/widgets/preview_step.dart';
import 'package:protiva502/features/service_provider/my_job_list/screen/widgets/tabItem.dart';

class PostJobScreen extends StatelessWidget {
  const PostJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateJobController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF09090B),
            size: 20,
          ),
          onPressed: () => controller.previousStep(),
        ),
        title: Text(
          'job Post',
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF3F3F3F),
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(color: Color(0xFFCBD5E1), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Text(
                'Post a Job in Minutes',
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Post a job, receive proposals, and hire the right professional with confidence.',
                style: getTextStyle(
                  fontSize: 14.sp,
                  color: Color(0xFF475569),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24.h),
              _buildStepIndicator(controller),
              SizedBox(height: 32.h),
              Obx(() {
                switch (controller.currentStep.value) {
                  case 0:
                    return const JobDetailsStep();
                  case 1:
                    return const ServiceDetailsStep();
                  case 2:
                    return const PreviewStep();
                  default:
                    return const JobDetailsStep();
                }
              }),
              SizedBox(height: 40.h),
              _buildBottomButton(controller),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(CreateJobController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TabItem(label: "Jobs details", index: 0, controller: controller),
        TabItem(label: "Service details", index: 1, controller: controller),
        TabItem(label: "Preview", index: 2, controller: controller),
      ],
    );
  }

  Widget _buildBottomButton(CreateJobController controller) {
    return Obx(() {
      bool isPreview = controller.currentStep.value == 2;
      return Container(
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          color: isPreview ? const Color(0xFF7079F0) : const Color(0xFF161C2C),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ElevatedButton(
          onPressed: isPreview ? controller.publishJob : controller.nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Text(
            isPreview ? 'Post Job' : 'Next Step',
            style: getTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }
}
