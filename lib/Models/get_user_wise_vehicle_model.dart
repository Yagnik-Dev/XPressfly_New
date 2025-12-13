class GetUserWiseVehicleResponseModel {
  String? message;
  List<GetUserVehicleData>? data;

  GetUserWiseVehicleResponseModel({this.message, this.data});

  GetUserWiseVehicleResponseModel.fromJson(Map<String, dynamic> json) {
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
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetUserVehicleData {
  int? id;
  String? vehicleModel;
  String? vehicleNumber;
  List<String>? zipCode;
  String? rcBookFront;
  String? rcBookBack;
  VehicleType? vehicleType;
  int? vehicleOwner;
  String? createdAt;
  String? updatedAt;

  GetUserVehicleData({
    this.id,
    this.vehicleModel,
    this.vehicleNumber,
    this.zipCode,
    this.rcBookFront,
    this.rcBookBack,
    this.vehicleType,
    this.vehicleOwner,
    this.createdAt,
    this.updatedAt,
  });

  GetUserVehicleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleModel = json['vehicle_model'];
    vehicleNumber = json['vehicle_number'];
    zipCode = json['zip_code'].cast<String>();
    rcBookFront = json['rc_book_front'];
    rcBookBack = json['rc_book_back'];
    vehicleType =
        json['vehicle_type'] != null
            ? VehicleType.fromJson(json['vehicle_type'])
            : null;
    vehicleOwner = json['vehicle_owner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vehicle_model'] = vehicleModel;
    data['vehicle_number'] = vehicleNumber;
    data['zip_code'] = zipCode;
    data['rc_book_front'] = rcBookFront;
    data['rc_book_back'] = rcBookBack;
    if (vehicleType != null) {
      data['vehicle_type'] = vehicleType!.toJson();
    }
    data['vehicle_owner'] = vehicleOwner;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class VehicleType {
  int? id;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? name;
  String? logo;
  String? image;
  String? colorCode;
  String? pricePerKm;
  String? description;

  VehicleType({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.name,
    this.logo,
    this.image,
    this.colorCode,
    this.pricePerKm,
    this.description,
  });

  VehicleType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    name = json['name'];
    logo = json['logo'];
    image = json['image'];
    colorCode = json['color_code'];
    pricePerKm = json['price_per_km'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_active'] = isActive;
    data['name'] = name;
    data['logo'] = logo;
    data['image'] = image;
    data['color_code'] = colorCode;
    data['price_per_km'] = pricePerKm;
    data['description'] = description;
    return data;
  }
}
