// import 'package:dio/dio.dart';
// import 'package:protiva502/core/utils/constants/apiendpoint.dart';
// import 'package:protiva502/core/utils/logging/logger.dart';

// class CallInviteResponse {
//   final bool success;
//   final String message;
//   final String? callId;
//   final String? requestId;

//   CallInviteResponse({
//     required this.success,
//     required this.message,
//     this.callId,
//     this.requestId,
//   });

//   factory CallInviteResponse.fromJson(Map<String, dynamic> json) {
//     return CallInviteResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? 'Unknown error',
//       callId: json['callId'],
//       requestId: json['requestId'],
//     );
//   }
// }

// class CallApiService {
//   final Dio _dio;

//   CallApiService({Dio? dio}) : _dio = dio ?? Dio();

//   Future<CallInviteResponse> sendCallInvite({
//     required String callerId,
//     required String callerName,
//     required String receiverId,
//     required String receiverName,
//     required String callType,
//     required String bookingId,
//   }) async {
//     try {
//       final response = await _dio.post(
//         '${ApiEndpoints.baseUrl}${ApiEndpoints.callInvite}',
//         data: {
//           'callerId': callerId,
//           'callerName': callerName,
//           'receiverId': receiverId,
//           'receiverName': receiverName,
//           'callType': callType,
//           'bookingId': bookingId,
//         },
//       );

//       final result = CallInviteResponse.fromJson(response.data);

//       AppLoggerHelper.info(
//         'Call invite sent: callerId=$callerId, receiverId=$receiverId, callId=${result.callId}',
//       );

//       return result;
//     } on DioException catch (e) {
//       final errorMessage = e.response?.data['message'] ?? 'Failed to send call invite';
//       AppLoggerHelper.error('Call invite error: $errorMessage');
//       return CallInviteResponse(
//         success: false,
//         message: errorMessage,
//       );
//     } catch (e) {
//       AppLoggerHelper.error('Unexpected error sending call invite: $e');
//       return CallInviteResponse(
//         success: false,
//         message: 'Unexpected error: ${e.toString()}',
//       );
//     }
//   }
// }
