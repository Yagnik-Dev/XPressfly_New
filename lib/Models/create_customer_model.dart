class CreateCustomerResponseModel {
  String? message;
  User? user;
  String? accessToken;
  String? refreshToken;

  CreateCustomerResponseModel({
    this.message,
    this.user,
    this.accessToken,
    this.refreshToken,
  });

  CreateCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }
}

class User {
  int? id;
  String? phone;
  String? profileImage;
  String? name;
  String? email;
  String? address;
  String? pincode;
  String? city;
  String? role;
  String? adharCardFront;
  String? adharCardBack;
  bool? isActive;
  bool? isPhoneVerified;
  bool? isVerified;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.phone,
    this.profileImage,
    this.name,
    this.email,
    this.address,
    this.pincode,
    this.city,
    this.role,
    this.adharCardFront,
    this.adharCardBack,
    this.isActive,
    this.isPhoneVerified,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    profileImage = json['profile_image'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    pincode = json['pincode'];
    city = json['city'];
    role = json['role'];
    adharCardFront = json['adhar_card_front'];
    adharCardBack = json['adhar_card_back'];
    isActive = json['is_active'];
    isPhoneVerified = json['is_phone_verified'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['profile_image'] = profileImage;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['pincode'] = pincode;
    data['city'] = city;
    data['role'] = role;
    data['adhar_card_front'] = adharCardFront;
    data['adhar_card_back'] = adharCardBack;
    data['is_active'] = isActive;
    data['is_phone_verified'] = isPhoneVerified;
    data['is_verified'] = isVerified;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
