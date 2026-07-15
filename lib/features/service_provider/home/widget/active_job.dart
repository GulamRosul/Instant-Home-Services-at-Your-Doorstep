import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/utils/constants/image_path.dart';
import 'package:protiva502/features/service_provider/home/controller/provider_home_controller.dart';
import 'package:protiva502/features/service_provider/home/model/active_job_model.dart';

class ActiveJobCard extends StatelessWidget {
  const ActiveJobCard({super.key, required this.job});

  final ActiveJobModel job;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: Color(0xFFCBD5E1)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3.r),
                    child: job.thumbnail.isNotEmpty
                        ? Image.network(
                            job.thumbnail,
                            width: 60.w,
                            height: 60.w,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              ImagePath.servicecard,
                              width: 60.w,
                              height: 60.w,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            ImagePath.servicecard,
                            width: 60.w,
                            height: 60.w,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(height: 6.h),
                  // Row(
                  //   children: [
                  //     SvgPicture.asset(IconPath.star, height: 15),
                  //     Text(
                  //       ' ${job.averageRating.toStringAsFixed(1)} ',
                  //       style: getTextStyle(
                  //         fontSize: 12.sp,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            job.title,
                            style: getTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.more_vert, color: Colors.black),
                      ],
                    ),

                    /// Location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: Color(0xFF1D4ED8),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            job.description.isNotEmpty
                                ? job.description
                                : 'remote_service'.tr,
                            style: getTextStyle(
                              fontSize: 11.sp,
                              color: Color(0xFF475569),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: RichText(
                        text: TextSpan(
                          text: 'Start From  ',
                          style: getTextStyle(
                            fontSize: 11.sp,
                            color: Color(0xFF475569),
                          ),
                          children: [
                            TextSpan(
                              text: '${job.basePrice.toStringAsFixed(0)} ৳',
                              style: getTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 10.h),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Flexible(
          //       child: _buildJobStat(
          //         Icons.visibility_outlined,
          //         "${job.views} views",
          //       ),
          //     ),
          //     Flexible(
          //       child: _buildJobStat(
          //         Icons.description_outlined,
          //         "${job.clicks} clicks",
          //       ),
          //     ),
          //     Flexible(
          //       child: _buildJobStat(
          //         Icons.calendar_month_outlined,
          //         "${job.totalBookings} bookings",
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildJobStat(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: Colors.black),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            text,
            style: getTextStyle(fontSize: 11.sp, color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class ActiveJobsSection extends StatelessWidget {
  const ActiveJobsSection({super.key, required this.controller});

  final ProviderHomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isActiveJobsLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.activeJobsErrorMessage.value.isNotEmpty) {
        return Text(
          controller.activeJobsErrorMessage.value,
          style: getTextStyle(fontSize: 12.sp, color: Colors.black54),
        );
      }

      if (controller.activeJobs.isEmpty) {
        return Center(
          child: Text(
            'no_active_jobs_found'.tr,
            textAlign: TextAlign.center,
            style: getTextStyle(fontSize: 12.sp, color: Colors.black54),
          ),
        );
      }

      return ActiveJobCard(job: controller.activeJobs.first);
    });
  }
}
