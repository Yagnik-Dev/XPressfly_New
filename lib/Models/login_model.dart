class LoginRequestModel {
  String? phone;
  String? otp;
  String? type;

  LoginRequestModel({this.phone, this.otp, this.type});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    otp = json['otp'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['otp'] = otp;
    data['type'] = type;
    return data;
  }
}

class LoginResponseModel {
  bool? status;
  String? message;
  String? token;
  User? user;

  LoginResponseModel({this.status, this.message, this.token, this.user});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? mobileNumber;
  Null mobileNumberVerifiedAt;
  String? pincode;
  String? city;
  int? userType;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.name,
    this.mobileNumber,
    this.mobileNumberVerifiedAt,
    this.pincode,
    this.city,
    this.userType,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    mobileNumberVerifiedAt = json['mobile_number_verified_at'];
    pincode = json['pincode'];
    city = json['city'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile_number'] = mobileNumber;
    data['mobile_number_verified_at'] = mobileNumberVerifiedAt;
    data['pincode'] = pincode;
    data['city'] = city;
    data['user_type'] = userType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
