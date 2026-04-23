import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/services/storage_service.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/chat/screen/single_chat_screen.dart';
import 'package:protiva502/features/service_provider/my_job_list/model/job_model.dart';
import 'package:protiva502/features/service_provider/my_job_list/screen/job_details_view_screen.dart';
import 'package:protiva502/features/user/provoder_details/model/provider_details_model.dart';

class ProviderDetailsController extends GetxController {
  ProviderDetailsController({required this.providerId});

  final String providerId;
  final ApiClient _apiClient = ApiClient();
  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final provider = Rxn<ProviderDetailsModel>();

  var selectedServiceTab = 0.obs;

  List<ProviderJobModel> get jobs => provider.value?.jobs ?? const [];

  List<ProviderReviewModel> get reviews =>
      provider.value?.receivedReviews ?? const [];

  ProviderJobModel? get selectedJob {
    if (jobs.isEmpty) {
      return null;
    }

    final index = selectedServiceTab.value.clamp(0, jobs.length - 1);
    return jobs[index];
  }

  String get displayName => provider.value?.fullName ?? 'Provider';

  String get ratingText {
    final rating = provider.value?.avgReview ?? 0;
    return rating % 1 == 0
        ? rating.toInt().toString()
        : rating.toStringAsFixed(1);
  }

  int get reviewCount => provider.value?.reviewCount ?? 0;

  int get servicesProvided => provider.value?.jobCount ?? 0;

  List<String> get skills {
    final uniqueSkills = <String>{};
    for (final job in jobs) {
      for (final item in job.includeService) {
        final value = item.trim();
        if (value.isNotEmpty) {
          uniqueSkills.add(value);
        }
      }
    }

    if (uniqueSkills.isEmpty) {
      for (final job in jobs) {
        final title = job.title.trim();
        if (title.isNotEmpty) {
          uniqueSkills.add(title);
        }
      }
    }

    return uniqueSkills.toList();
  }

  String get locationText {
    final details = provider.value;
    if (details == null) {
      return 'Location not available';
    }

    final parts = <String>[
      if ((details.city ?? '').trim().isNotEmpty) details.city!.trim(),
      if ((details.state ?? '').trim().isNotEmpty) details.state!.trim(),
      _countryLabel(details.country),
    ];

    if (parts.isEmpty) {
      return 'Location not available';
    }

    return parts.join(', ');
  }

  String get aboutTitle => 'About $displayName';

  String get aboutDescription {
    final bio = provider.value?.bio?.trim();
    if (bio != null && bio.isNotEmpty) {
      return bio;
    }

    return '$displayName offers professional services tailored to your needs.';
  }

  bool get isVerified =>
      provider.value?.verificationStatus.toUpperCase() == 'VERIFIED';

  bool get isServiceAvailable =>
      provider.value?.providerServiceAvailability == true;

  @override
  void onInit() {
    super.onInit();
    fetchProviderDetails();
  }

  void changeServiceTab(int index) {
    selectedServiceTab.value = index;
  }

  Future<void> fetchProviderDetails() async {
    if (providerId.trim().isEmpty) {
      errorMessage.value = 'Provider id is missing';
      isLoading.value = false;
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.providerDetails(providerId),
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final responseMap = _asMap(response.data);
      final data = _asMap(responseMap?['data']);

      if (response.statusCode != 200 || data == null) {
        provider.value = null;
        errorMessage.value =
            _extractMessage(response.data) ?? 'Failed to load provider details';
        return;
      }

      provider.value = ProviderDetailsModel.fromJson(data);

      if (selectedServiceTab.value >= jobs.length) {
        selectedServiceTab.value = 0;
      }
    } on DioException catch (error) {
      provider.value = null;
      errorMessage.value =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to load provider details';
      AppLoggerHelper.error('Provider details fetch failed', error);
    } catch (error) {
      provider.value = null;
      errorMessage.value = 'Failed to load provider details';
      AppLoggerHelper.error('Unexpected provider details fetch error', error);
    } finally {
      isLoading.value = false;
    }
  }

  void sendMessage() {
    if (providerId.trim().isEmpty) {
      Get.snackbar('Error', 'Provider information is not available');
      return;
    }

    final userId = StorageService.getUserId() ?? '';

    Get.to(
      () => const SingleChatScreen(),
      arguments: {
        'providerId': providerId,
        'clientId': userId,
        'providerName': displayName,
        'userId': userId,
        'userRole': 'user',
      },
    );
  }

  void bookSpecificService(String serviceId) {
    ProviderJobModel? job;
    try {
      job = jobs.firstWhere((j) => j.id == serviceId);
    } catch (e) {
      Get.snackbar('Error', 'Service not found');
      return;
    }

    if (job != null) {
      // Convert ProviderJobModel to JobModel
      final jobModel = JobModel(
        id: job.id,
        userId: providerId,
        categoryId: '',
        subCategoryId: '',
        title: job.title,
        slug: '',
        description: job.description,
        basePrice: job.basePrice.toString(),
        priceType: 'FIXED',
        includeService: job.includeService,
        thumbnail: job.thumbnail,
        images: const [],
        videos: const [],
        status: job.status,
        views: 0,
        clicks: 0,
        totalBookings: job.totalBookings,
        averageRating: job.averageRating,
        isPopuler: false,
        createdAt: '',
        updatedAt: '',
      );

      Get.to(() => const JobDetailsViewScreen(), arguments: jobModel);
    }
  }

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return value.map((key, item) => MapEntry(key.toString(), item));
    }

    return null;
  }

  String? _extractMessage(dynamic responseData) {
    final responseMap = _asMap(responseData);
    final data = _asMap(responseMap?['data']);
    final message = data?['message'] ?? responseMap?['message'];

    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    return null;
  }

  String _countryLabel(String? code) {
    switch ((code ?? '').toUpperCase()) {
      case 'BD':
        return 'Bangladesh';
      case 'US':
        return 'United States';
      default:
        return (code ?? '').trim();
    }
  }
}
