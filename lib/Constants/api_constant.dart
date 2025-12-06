class ApiConstant {
  static const String baseUrl = "https://api.xpressfly.in/";
  // static const String baseUrl =
  //     "https://enneasyllabic-faunal-latoyia.ngrok-free.dev/";
  static const String sendOtp = "user/send-otp/";
  // static const String register = "auth/register";
  static const String verifyOtp = "user/verify-otp/";
  static const String createDriver = "user/create-driver/";
  static const String createCustomer = "user/create-customer/";
  static const String profile = "users";
  static const String toggleDuty = "duty/toggle";
  // static const String userWiseVehicle = "vehicles/user";
  static const String userWiseVehicle = "delivery/vehicles/";
  static const String vehicleTypes = "metadata/vehicle-type/";
  static const String vehiclesDetails = "vehicles";
  static const String commonErrorMessage = "Something went wrong";

  // ================ Forgot Password ====================
  static const String forgotPwd = 'password/email';
  static const String resetPwd = 'password/reset';
}
