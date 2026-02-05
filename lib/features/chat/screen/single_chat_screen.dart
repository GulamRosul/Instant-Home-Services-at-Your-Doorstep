import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/common/styles/global_text_style.dart';
import 'package:protiva502/core/common/widgets/custom_appbar.dart';
import 'package:protiva502/core/common/widgets/custom_textfield.dart';
import 'package:protiva502/core/utils/constants/colors.dart';
import 'package:protiva502/features/chat/controller/single_chat_controller.dart';

class SingleChatScreen extends StatelessWidget {
  const SingleChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SingleChatController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      // This ensures the body shrinks when the keyboard appears
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: 'Mike Handyman', // Name from screenshot
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                padding: EdgeInsets.all(20.r),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final chat = controller.messages[index];
                  return _buildChatBubble(
                    chat['message'],
                    chat['isMe'],
                    chat['time'],
                  );
                },
              ),
            ),
          ),

          // Message Input Field
          _buildMessageInput(controller),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String message, bool isMe, String time) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        constraints: BoxConstraints(maxWidth: Get.width * 0.75),
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: isMe ? AppColors.textPurple : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: isMe ? Radius.circular(16.r) : Radius.zero,
            bottomRight: isMe ? Radius.zero : Radius.circular(16.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: getTextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              time,
              style: getTextStyle(
                color: isMe ? Colors.white70 : Colors.grey,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(SingleChatController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Attachment Button
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.grey,
                size: 28.sp,
              ),
            ),

            // Text Field
            // Expanded(
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 16.w),
            //     decoration: BoxDecoration(
            //       color: const Color(0xFFF3F4F6),
            //       borderRadius: BorderRadius.circular(25.r),
            //     ),
            //     child: TextField(
            //       controller: controller.messageController,
            //       decoration: InputDecoration(
            //         hintText: "Type a message...",
            //         hintStyle: getTextStyle(
            //           color: Colors.grey,
            //           fontSize: 14.sp,
            //         ),
            //         border: InputBorder.none,
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(child: CustomTextField(backgroundColor: Colors.white)),
            SizedBox(width: 10.w),

            // Send Button
            GestureDetector(
              onTap: controller.sendMessage,
              child: CircleAvatar(
                radius: 22.r,
                backgroundColor: AppColors.textPurple,
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
