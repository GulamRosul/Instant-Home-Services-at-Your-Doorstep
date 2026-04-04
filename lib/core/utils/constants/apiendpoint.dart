class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://protiva-backend.onrender.com/api/v1';
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String userBanners = '/marketing/user/banners';
  static const String homeJobs = '/job/home-jobs';


  static const String categories = '/category/all-categoris-for-user';
  static String subCategories(String categoryId) => '/category/sub-categories/$categoryId';
}
