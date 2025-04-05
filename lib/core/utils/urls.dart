class Urls {
  // Base Url
  static String baseUrl = "https://cart-app-backend-3kpk.onrender.com/api";

  // Endpoints
  static String register = "/users/register";
  static String login = "/users/login";
  static String home = "/product";
  static String cart = "/cart";
  static String addcart = "/cart/add";
  static String remove(String productId) => "/cart/$productId";
}
