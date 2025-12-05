class OtpResponseModel {
  String? message;
  String? phone;
  String? otp;

  OtpResponseModel({this.message, this.phone, this.otp});

  OtpResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    phone = json['phone'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['phone'] = phone;
    data['otp'] = otp;
    return data;
  }
}

class VerifyOtpResponseModel {
  String? message;
  String? phone;
  bool? isPhoneVerified;

  VerifyOtpResponseModel({this.message, this.phone, this.isPhoneVerified});

  VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    phone = json['phone'];
    isPhoneVerified = json['is_phone_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['phone'] = phone;
    data['is_phone_verified'] = isPhoneVerified;
    return data;
  }
}
