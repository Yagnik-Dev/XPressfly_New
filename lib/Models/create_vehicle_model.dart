class CreateVehicleResponseModel {
  bool? success;
  String? message;
  Data? data;

  CreateVehicleResponseModel({this.success, this.message, this.data});

  CreateVehicleResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? fullName;
  String? mobileNumber;
  String? licenseNumber;
  String? address;
  String? vehicleModel;
  String? vehicleNumber;
  String? vehicleType;
  List<String>? deliveryPincodes;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({
    this.userId,
    this.fullName,
    this.mobileNumber,
    this.licenseNumber,
    this.address,
    this.vehicleModel,
    this.vehicleNumber,
    this.vehicleType,
    this.deliveryPincodes,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    mobileNumber = json['mobile_number'];
    licenseNumber = json['license_number'];
    address = json['address'];
    vehicleModel = json['vehicle_model'];
    vehicleNumber = json['vehicle_number'];
    vehicleType = json['vehicle_type'];
    deliveryPincodes = json['delivery_pincodes'].cast<String>();
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['full_name'] = fullName;
    data['mobile_number'] = mobileNumber;
    data['license_number'] = licenseNumber;
    data['address'] = address;
    data['vehicle_model'] = vehicleModel;
    data['vehicle_number'] = vehicleNumber;
    data['vehicle_type'] = vehicleType;
    data['delivery_pincodes'] = deliveryPincodes;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
