class GetUserProfileDataModel {
  bool? status;
  String? message;
  ProfileData? data;

  GetUserProfileDataModel({this.status, this.message, this.data});

  GetUserProfileDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  int? id;
  String? name;
  String? mobileNumber;
  String? mobileNumberVerifiedAt;
  String? pincode;
  String? city;
  int? userType;
  String? createdAt;
  String? updatedAt;

  ProfileData({
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

  ProfileData.fromJson(Map<String, dynamic> json) {
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
