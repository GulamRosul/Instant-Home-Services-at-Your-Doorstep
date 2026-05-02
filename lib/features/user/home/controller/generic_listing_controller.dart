import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Enum to specify the type of listing
enum ListingType { popularServices, allServices, recommendedExperts }

/// Generic controller for paginated listings
class GenericListingController<T> extends GetxController {
  final String title;
  final ListingType type;
  final List<T> initialItems;
  final Future<List<T>> Function(int page, int limit) fetchFunction;

  // Observable properties
  final items = <T>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final errorMessage = ''.obs;
  final hasMoreData = true.obs;

  // Pagination properties
  late final int initialBatchSize;
  late final int subsequentBatchSize;
  int currentPage = 1;
  bool _isInitialized = false;

  final ScrollController scrollController = ScrollController();

  GenericListingController({
    required this.title,
    required this.type,
    required this.initialItems,
    required this.fetchFunction,
  }) {
    // Set batch sizes based on type
    switch (type) {
      case ListingType.popularServices:
      case ListingType.allServices:
        initialBatchSize = 6;
        subsequentBatchSize = 4;
        break;
      case ListingType.recommendedExperts:
        initialBatchSize = 10;
        subsequentBatchSize = 5;
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initializeListener();
    _loadInitialData();
  }

  void _initializeListener() {
    scrollController.addListener(_onScroll);
  }

  Future<void> _loadInitialData() async {
    if (_isInitialized) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Load initial batch
      final fetchedItems = await fetchFunction(1, initialBatchSize);

      items.assignAll(fetchedItems);
      currentPage = 1;

      // Check if there are more items
      if (fetchedItems.length < initialBatchSize) {
        hasMoreData.value = false;
      }

      _isInitialized = true;
    } catch (error) {
      errorMessage.value = 'failed_load_items'.tr;
      debugPrint('Error loading initial data: $error');
    } finally {
      isLoading.value = false;
    }
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;

    // Trigger load when user scrolls to 80% of the list
    if (currentScroll >= (maxScroll * 0.8)) {
      _loadMoreItems();
    }
  }

  Future<void> _loadMoreItems() async {
    if (!hasMoreData.value || isLoadingMore.value || isLoading.value) return;

    try {
      isLoadingMore.value = true;
      errorMessage.value = '';

      currentPage++;
      final fetchedItems = await fetchFunction(
        currentPage,
        subsequentBatchSize,
      );

      if (fetchedItems.isEmpty) {
        hasMoreData.value = false;
      } else {
        items.addAll(fetchedItems);

        // If fetched less than requested, we've reached the end
        if (fetchedItems.length < subsequentBatchSize) {
          hasMoreData.value = false;
        }
      }
    } catch (error) {
      currentPage--; // Revert page increment on error
      errorMessage.value = 'failed_load_more_items'.tr;
      debugPrint('Error loading more items: $error');
    } finally {
      isLoadingMore.value = false;
    }
  }

  void retry() {
    currentPage = 1;
    items.clear();
    hasMoreData.value = true;
    _isInitialized = false;
    _loadInitialData();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
