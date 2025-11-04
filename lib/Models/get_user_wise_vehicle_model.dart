class GetUserWiseVehicleResponseModel {
  bool? success;
  String? message;
  List<GetUserVehicleData>? data;

  GetUserWiseVehicleResponseModel({this.success, this.message, this.data});

  GetUserWiseVehicleResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetUserVehicleData>[];
      json['data'].forEach((v) {
        data!.add(GetUserVehicleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetUserVehicleData {
  int? id;
  int? userId;
  String? fullName;
  String? mobileNumber;
  String? licenseNumber;
  String? licenseImage;
  String? address;
  String? vehicleModel;
  String? vehicleNumber;
  String? vehicleType;
  String? deliveryPincodes;
  Null adharFrontImage;
  Null adharBackImage;
  Null rcFrontImage;
  Null rcBackImage;
  String? createdAt;
  String? updatedAt;

  GetUserVehicleData({
    this.id,
    this.userId,
    this.fullName,
    this.mobileNumber,
    this.licenseNumber,
    this.licenseImage,
    this.address,
    this.vehicleModel,
    this.vehicleNumber,
    this.vehicleType,
    this.deliveryPincodes,
    this.adharFrontImage,
    this.adharBackImage,
    this.rcFrontImage,
    this.rcBackImage,
    this.createdAt,
    this.updatedAt,
  });

  GetUserVehicleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    mobileNumber = json['mobile_number'];
    licenseNumber = json['license_number'];
    licenseImage = json['license_image'];
    address = json['address'];
    vehicleModel = json['vehicle_model'];
    vehicleNumber = json['vehicle_number'];
    vehicleType = json['vehicle_type'];
    deliveryPincodes = json['delivery_pincodes'];
    adharFrontImage = json['adhar_front_image'];
    adharBackImage = json['adhar_back_image'];
    rcFrontImage = json['rc_front_image'];
    rcBackImage = json['rc_back_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['full_name'] = fullName;
    data['mobile_number'] = mobileNumber;
    data['license_number'] = licenseNumber;
    data['license_image'] = licenseImage;
    data['address'] = address;
    data['vehicle_model'] = vehicleModel;
    data['vehicle_number'] = vehicleNumber;
    data['vehicle_type'] = vehicleType;
    data['delivery_pincodes'] = deliveryPincodes;
    data['adhar_front_image'] = adharFrontImage;
    data['adhar_back_image'] = adharBackImage;
    data['rc_front_image'] = rcFrontImage;
    data['rc_back_image'] = rcBackImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
