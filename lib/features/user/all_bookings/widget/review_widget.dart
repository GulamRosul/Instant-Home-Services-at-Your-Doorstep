import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/user/all_bookings/controller/review_controller.dart';

class ReviewWidget extends StatelessWidget {
  final String bookingId;
  final String receiverId;
  final String jobId;

  const ReviewWidget({
    super.key,
    required this.bookingId,
    required this.receiverId,
    required this.jobId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReviewController());
    controller.initializeWithBookingData(
      bookingId: bookingId,
      receiverId: receiverId,
      jobId: jobId,
    );

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "how_would_you_rate_your_experience".tr,
              textAlign: TextAlign.center,
              style: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 8.h),
            Text(
              "Share your thoughts to help others make the right choice.",
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 20.h),

            // Star Rating Row
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => controller.updateRating(index + 1),
                    child: Icon(
                      index < controller.rating.value
                          ? Icons.star
                          : Icons.star_border,
                      color: index < controller.rating.value
                          ? Colors.orange
                          : Colors.grey.shade400,
                      size: 32.sp,
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height: 24.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "can_you_tell_us_more".tr,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Feedback Area with Image Preview
            Stack(
              children: [
                CustomTextField(
                  controller: controller.feedbackController,
                  hintText: "add_feedback".tr,
                  maxLines: 5,
                  backgroundColor: Colors.white,
                ),
                Positioned(
                  bottom: 10.h,
                  right: 10.w,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            controller.pickImage(ImageSource.gallery),
                        icon: Icon(
                          Icons.image_outlined,
                          color: Colors.grey,
                          size: 20.sp,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            controller.pickImage(ImageSource.camera),
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Picked Images Preview List
            Obx(
              () => controller.selectedImages.isEmpty
                  ? const SizedBox()
                  : Container(
                      height: 60.h,
                      margin: EdgeInsets.only(top: 10.h),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.selectedImages.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8.w),
                                width: 60.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  image: DecorationImage(
                                    image: FileImage(
                                      controller.selectedImages[index],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 8.w,
                                child: GestureDetector(
                                  onTap: () => controller.removeImage(index),
                                  child: CircleAvatar(
                                    radius: 8.r,
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      Icons.close,
                                      size: 10.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
            ),

            SizedBox(height: 24.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "cancel".tr,
                      style: getTextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isSubmitting.value
                          ? null
                          : controller.submitReview,
                      style:
                          ElevatedButton.styleFrom(
                            backgroundColor: AppColors.textPurple,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ).copyWith(
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                            side: WidgetStateProperty.all(BorderSide.none),
                          ),
                      child: controller.isSubmitting.value
                          ? SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              "submit".tr,
                              style: getTextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
