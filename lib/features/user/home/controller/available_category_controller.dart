import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protiva502/core/services/api_client.dart';
import 'package:protiva502/core/utils/constants/apiendpoint.dart';
import 'package:protiva502/core/utils/logging/logger.dart';
import 'package:protiva502/features/user/home/model/categories_model.dart';
import 'package:protiva502/features/user/home/model/sub_category_model.dart';

class AvailableCategoryController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // Scroll controller for horizontal category list
  final ScrollController categoriesScrollController = ScrollController();

  // Observable for selected category index
  var selectedIndex = 0.obs;

  // Observables for categories
  final isCategoriesLoading = false.obs;
  final categoriesErrorMessage = ''.obs;
  final categories = <CategoryModel>[].obs;
  var currentCategoryPage = 1.obs;
  var totalCategoryPages = 1.obs;

  // Observables for sub-categories
  final isSubCategoriesLoading = false.obs;
  final subCategoriesErrorMessage = ''.obs;
  final subCategories = <SubCategoryModel>[].obs;
  var currentSubCategoryPage = 1.obs;
  var totalSubCategoryPages = 1.obs;

  @override
  void onInit() {
    super.onInit();
    // categoriesScrollController = ScrollController();
    fetchCategories();
    // refresh();
  }

  @override
  void onClose() {
    categoriesScrollController.dispose();
    super.onClose();
  }

  void selectCategoryAfterLoad(int index) {
    if (categories.isNotEmpty) {
      // Categories already loaded, select immediately
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selectCategory(index);
      });
      return;
    }

    // Use once() instead of ever() — fires only one time then disposes itself
    once(isCategoriesLoading, (bool loading) {
      if (!loading && categories.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          selectCategory(index);
        });
      }
    });
  }

  void _scrollToCategory(int index) {
    if (!categoriesScrollController.hasClients) return;
    if (categoriesScrollController.positions.isEmpty) return; // ✅ extra guard

    const double itemWidth = 92.0;
    const double horizontalPadding = 20.0;

    double targetOffset = (index * itemWidth) - horizontalPadding;
    final maxOffset = categoriesScrollController.position.maxScrollExtent;
    targetOffset = targetOffset.clamp(0.0, maxOffset);

    categoriesScrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> fetchCategories({int page = 1}) async {
    try {
      isCategoriesLoading.value = true;
      categoriesErrorMessage.value = '';

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.categories,
        queryParameters: {'page': page, 'limit': 20},
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      AppLoggerHelper.info(
        'Categories response status: ${response.statusCode}',
      );
      AppLoggerHelper.info('Categories response body: ${response.data}');

      List<CategoryModel> fetchedCategories = [];

      if (response.statusCode == 200) {
        // Extract categories data - handle multiple possible response structures
        final categoriesData = _extractCategoriesData(response.data);

        if (categoriesData.isNotEmpty) {
          fetchedCategories =
              categoriesData
                  .map(
                    (category) => CategoryModel.fromJson(
                      category.map(
                        (key, value) => MapEntry(key.toString(), value),
                      ),
                    ),
                  )
                  .where((category) => category.isActive)
                  .toList()
                ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        }
      }

      if (fetchedCategories.isEmpty && response.statusCode != 200) {
        categories.clear();
        categoriesErrorMessage.value =
            _extractMessage(response.data) ?? 'Failed to load categories';
        AppLoggerHelper.warning(
          'Failed to fetch categories: ${categoriesErrorMessage.value}',
        );
        return;
      }

      if (page == 1) {
        categories.assignAll(fetchedCategories);
        selectedIndex.value = 0;
        // Fetch sub-categories for the first category
        if (fetchedCategories.isNotEmpty) {
          fetchSubCategories(fetchedCategories[0].id);
          // Scroll to the selected category after a short delay to ensure ListView is built
          Future.delayed(const Duration(milliseconds: 100), () {
            _scrollToCategory(selectedIndex.value);
          });
        }
      } else {
        categories.addAll(fetchedCategories);
      }

      currentCategoryPage.value = page;
      AppLoggerHelper.info(
        'Fetched ${fetchedCategories.length} categories (page: $page)',
      );
    } on DioException catch (error) {
      if (currentCategoryPage.value == 1) {
        categories.clear();
      }
      categoriesErrorMessage.value =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to load categories';
      AppLoggerHelper.error('Categories fetch failed', error);
    } catch (error) {
      if (currentCategoryPage.value == 1) {
        categories.clear();
      }
      categoriesErrorMessage.value = 'Failed to load categories';
      AppLoggerHelper.error('Unexpected categories fetch error', error);
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  String? _extractMessage(dynamic responseData) {
    final responseMap = _asMap(responseData);
    if (responseMap == null) {
      return null;
    }

    final data = _asMap(responseMap['data']);
    final message = data?['message'] ?? responseMap['message'];

    if (message is String && message.trim().isNotEmpty) {
      return message;
    }

    return null;
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

  void selectCategory(int index) {
    selectedIndex.value = index;
    _scrollToCategory(index);
    if (categories.isNotEmpty && index < categories.length) {
      fetchSubCategories(categories[index].id);
    }
  }

  Future<void> fetchSubCategories(String categoryId, {int page = 1}) async {
    try {
      isSubCategoriesLoading.value = true;
      subCategoriesErrorMessage.value = '';

      final response = await _apiClient.get<dynamic>(
        ApiEndpoints.subCategories(categoryId),
        queryParameters: {'page': page, 'limit': 20},
        options: Options(
          headers: const {'accept': '*/*'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      AppLoggerHelper.info(
        'Sub-categories response status: ${response.statusCode}',
      );
      AppLoggerHelper.info('Sub-categories response body: ${response.data}');

      List<SubCategoryModel> fetchedSubCategories = [];

      if (response.statusCode == 200) {
        // Extract sub-categories data - handle multiple possible response structures
        final subCategoriesData = _extractSubCategoriesData(response.data);

        if (subCategoriesData.isNotEmpty) {
          fetchedSubCategories =
              subCategoriesData
                  .map(
                    (subCategory) => SubCategoryModel.fromJson(
                      subCategory.map(
                        (key, value) => MapEntry(key.toString(), value),
                      ),
                    ),
                  )
                  .where((subCategory) => subCategory.isActive)
                  .toList()
                ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        }
      }

      if (fetchedSubCategories.isEmpty && response.statusCode != 200) {
        subCategories.clear();
        subCategoriesErrorMessage.value =
            _extractMessage(response.data) ?? 'Failed to load sub-categories';
        AppLoggerHelper.warning(
          'Failed to fetch sub-categories: ${subCategoriesErrorMessage.value}',
        );
        return;
      }

      if (page == 1) {
        subCategories.assignAll(fetchedSubCategories);
      } else {
        subCategories.addAll(fetchedSubCategories);
      }

      currentSubCategoryPage.value = page;
      AppLoggerHelper.info(
        'Fetched ${fetchedSubCategories.length} sub-categories for category: $categoryId (page: $page)',
      );
    } on DioException catch (error) {
      if (currentSubCategoryPage.value == 1) {
        subCategories.clear();
      }
      subCategoriesErrorMessage.value =
          _extractMessage(error.response?.data) ??
          error.message ??
          'Failed to load sub-categories';
      AppLoggerHelper.error('Sub-categories fetch failed', error);
    } catch (error) {
      if (currentSubCategoryPage.value == 1) {
        subCategories.clear();
      }
      subCategoriesErrorMessage.value = 'Failed to load sub-categories';
      AppLoggerHelper.error('Unexpected sub-categories fetch error', error);
    } finally {
      isSubCategoriesLoading.value = false;
    }
  }

  // Extract categories from various possible API response structures
  List<Map> _extractCategoriesData(dynamic responseData) {
    final responseMap = _asMap(responseData) ?? <String, dynamic>{};

    // Try different possible response structures
    // Structure 1: { data: { data: { data: [...] } } }
    var data = _asMap(responseMap['data']);
    if (data != null) {
      var nestedData = _asMap(data['data']);
      if (nestedData != null) {
        var categoriesData = nestedData['data'];
        if (categoriesData is List) {
          return categoriesData.whereType<Map>().toList();
        }
      }
    }

    // Structure 2: { data: [...] } - direct array in data
    if (responseMap['data'] is List) {
      return responseMap['data'].whereType<Map>().toList();
    }

    // Structure 3: { data: { categories: [...] } }
    data = _asMap(responseMap['data']);
    if (data != null && data['categories'] is List) {
      return data['categories'].whereType<Map>().toList();
    }

    return [];
  }

  // Extract sub-categories from various possible API response structures
  List<Map> _extractSubCategoriesData(dynamic responseData) {
    final responseMap = _asMap(responseData) ?? <String, dynamic>{};

    // Try different possible response structures
    // Structure 1: { data: { data: { data: [...] } } }
    var data = _asMap(responseMap['data']);
    if (data != null) {
      var nestedData = _asMap(data['data']);
      if (nestedData != null) {
        var subCategoriesData = nestedData['data'];
        if (subCategoriesData is List) {
          return subCategoriesData.whereType<Map>().toList();
        }
      }
    }

    // Structure 2: { data: [...] } - direct array in data
    if (responseMap['data'] is List) {
      return responseMap['data'].whereType<Map>().toList();
    }

    // Structure 3: { data: { subCategories: [...] } }
    data = _asMap(responseMap['data']);
    if (data != null && data['subCategories'] is List) {
      return data['subCategories'].whereType<Map>().toList();
    }

    return [];
  }
}
