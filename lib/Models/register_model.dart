class RegisterUserResponseModel {
  String? status;
  User? user;

  RegisterUserResponseModel({this.status, this.user});

  RegisterUserResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
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
  String? pincode;
  String? city;
  int? userType;
  String? updatedAt;
  String? createdAt;

  User({
    this.id,
    this.name,
    this.mobileNumber,
    this.pincode,
    this.city,
    this.userType,
    this.updatedAt,
    this.createdAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    pincode = json['pincode'];
    city = json['city'];
    userType = json['user_type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile_number'] = mobileNumber;
    data['pincode'] = pincode;
    data['city'] = city;
    data['user_type'] = userType;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
