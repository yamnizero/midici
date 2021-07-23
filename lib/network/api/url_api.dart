class BASEURL {
  static String ipAddress = "172.20.10.5";

  static String apiRegister = "http://$ipAddress:8080/medicine_db/register_api.php";
  static String apiLogin = "http://$ipAddress:8080/medicine_db/login_api.php";
  static String categoryWithProduct = "http://$ipAddress:8080/medicine_db/get_product_with_category.php";
  static String getProduct = "http://$ipAddress:8080/medicine_db/get_product.php";
  static String addToCArt = "http://$ipAddress:8080/medicine_db/add_to_cart.php";
  static String getProductCart = "http://$ipAddress:8080/medicine_db/get_cart.php?userID=";
  static String updateQuantityProductCart="http://$ipAddress:8080/medicine_db/update_quantity.php";
  static String totalPriceCart="http://$ipAddress:8080/medicine_db/get_total_price.php?userID=";
  static String getTotalCart="http://$ipAddress:8080/medicine_db/total_cart.php?userID=";
  static String checkout="http://$ipAddress:8080/medicine_db/checkout.php";


}