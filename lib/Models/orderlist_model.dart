class OrderListResponseModel {
  String? message;
  List<Data>? data;

  OrderListResponseModel({this.message, this.data});

  OrderListResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? title;
  String? receiverName;
  String? receiverPhoneNumber;
  String? fromAddress;
  String? toAddress;
  String? fromZipCode;
  String? toZipCode;
  String? pickupDate;
  String? distance;
  String? status;
  String? vehicleType;
  String? weightInKg;
  List<AvailableTimes>? availableTimes;
  List<String>? images;
  int? customer;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.title,
    this.receiverName,
    this.receiverPhoneNumber,
    this.fromAddress,
    this.toAddress,
    this.fromZipCode,
    this.toZipCode,
    this.pickupDate,
    this.distance,
    this.status,
    this.vehicleType,
    this.weightInKg,
    this.availableTimes,
    this.images,
    this.customer,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    receiverName = json['receiver_name'];
    receiverPhoneNumber = json['receiver_phone_number'];
    fromAddress = json['from_address'];
    toAddress = json['to_address'];
    fromZipCode = json['from_zip_code'];
    toZipCode = json['to_zip_code'];
    pickupDate = json['pickup_date'];
    distance = json['distance'];
    status = json['status'];
    vehicleType = json['vehicle_type'];
    weightInKg = json['weight_in_kg'];
    if (json['available_times'] != null) {
      availableTimes = <AvailableTimes>[];
      json['available_times'].forEach((v) {
        availableTimes!.add(AvailableTimes.fromJson(v));
      });
    }
    images = json['images'].cast<String>();
    customer = json['customer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['receiver_name'] = receiverName;
    data['receiver_phone_number'] = receiverPhoneNumber;
    data['from_address'] = fromAddress;
    data['to_address'] = toAddress;
    data['from_zip_code'] = fromZipCode;
    data['to_zip_code'] = toZipCode;
    data['pickup_date'] = pickupDate;
    data['distance'] = distance;
    data['status'] = status;
    data['vehicle_type'] = vehicleType;
    data['weight_in_kg'] = weightInKg;
    if (availableTimes != null) {
      data['available_times'] = availableTimes!.map((v) => v.toJson()).toList();
    }
    data['images'] = images;
    data['customer'] = customer;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class AvailableTimes {
  String? fromTime;
  String? toTime;

  AvailableTimes({this.fromTime, this.toTime});

  AvailableTimes.fromJson(Map<String, dynamic> json) {
    fromTime = json['from_time'];
    toTime = json['to_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from_time'] = fromTime;
    data['to_time'] = toTime;
    return data;
  }
}
