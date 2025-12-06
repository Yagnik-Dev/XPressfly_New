class GetVehicleTypeResponseModel {
  String? message;
  List<Data>? data;

  GetVehicleTypeResponseModel({this.message, this.data});

  GetVehicleTypeResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
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

  Data({
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

  Data.fromJson(Map<String, dynamic> json) {
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
