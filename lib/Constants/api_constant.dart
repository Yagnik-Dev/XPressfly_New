class ApiConstant {
  static const String baseUrl = "https://api.xpressfly.in/";
  // static const String baseUrl =
  //     "https://enneasyllabic-faunal-latoyia.ngrok-free.dev/";
  static const String sendOtp = "user/send-otp/";
  // static const String register = "auth/register";
  static const String verifyOtp = "user/verify-otp/";
  static const String createDriver = "user/create-driver/";
  static const String createCustomer = "user/create-customer/";
  static const String createVehicles = "delivery/vehicles/create/";
  static const String updateVehicles = "delivery/vehicles/update/";
  static const String deleteVehicles = "delivery/vehicles/delete/";
  static const String profile = "user/";
  static const String updateDriverProfile = "user/update-driver/";
  static const String updateCustomerProfile = "user/update-customer/";
  static const String toggleDuty = "duty/toggle";
  // static const String userWiseVehicle = "vehicles/user";
  static const String userWiseVehicle = "delivery/vehicles/";
  static const String vehicleList = "delivery/vehicles/";
  static const String refreshToken = "user/refresh-token/";
  static const String vehicleTypes = "metadata/vehicle-type/";
  static const String vehiclesDetails = "vehicles";
  static const String updateOrderStatus = "delivery/orders/status/";
  static const String retryOrder = "delivery/orders/retry/";
  static const String orderList = "delivery/orders/";
  static const String privacyPolicy = "metadata/privacy-policy/";
  static const String termsAndConditions = "metadata/term-and-condition/";
  static const String createOrder = "delivery/orders/create/";
  static const String commonErrorMessage = "Something went wrong";

  // ================ Forgot Password ====================
  static const String forgotPwd = 'password/email';
  static const String resetPwd = 'password/reset';
}
