class ApiEndpoint {
  static const String Register = '/api/Authentication/Register';
  static const String login = '/api/Authentication/Login';
  static const String verifyEmail = '/api/Authentication/VerifyEmail';
 // static const String verifyotp = '/api/Authentication/verify-otp';
  static const String checkEmailOtp = '/api/Authentication/CheckEmailOtp';
  static const String forgetPassword = '/api/Authentication/forget-password';

 static const String resetPassword = '/api/Authentication/reset-password';
  static const String googleLogin =
      '/api/Authentication/google-login';
  static const String createProduct = '/api/Products/CreateProduct';
  static String updateProduct = '/api/Products/UpdateProduct';
  static const String DeleteProdect = '/api/Products/UpdateProduct';
  static const String GetAllProdecCategories='/api/Products/GetAllProductCategories';
  static const String GetAllProdets='/api/Products/GetAllProducts';
  static const String GetAllCategoriesById='/api/Products/GetAllProductCategoriesById?id';
 static const String get_top_prodects='/api/Home/top-products';
  static const String get_top_sellers='/api/Home/top-sellers';
  static const String delete='/api/Products/DeleteProduct';


}

