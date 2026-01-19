class OrderData {
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
  Customer? customer;
  String? createdAt;
  String? updatedAt;
  int? vehicleTypeId;

  OrderData({
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
    this.vehicleTypeId,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'],
      title: json['title'],
      receiverName: json['receiver_name'],
      receiverPhoneNumber: json['receiver_phone_number'],
      fromAddress: json['from_address'],
      toAddress: json['to_address'],
      fromZipCode: json['from_zip_code'],
      toZipCode: json['to_zip_code'],
      pickupDate: json['pickup_date'],
      distance: json['distance'],
      status: json['status'],
      vehicleType: json['vehicle_type'],
      weightInKg: json['weight_in_kg'],
      availableTimes:
          (json['available_times'] as List<dynamic>?)
              ?.map((e) => AvailableTimes.fromJson(e as Map<String, dynamic>))
              .toList(),
      images: (json['images'] as List<dynamic>?)?.cast<String>(),
      customer:
          json['customer'] != null
              ? Customer.fromJson(json['customer'] as Map<String, dynamic>)
              : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      vehicleTypeId: json['vehicle_type_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'receiver_name': receiverName,
      'receiver_phone_number': receiverPhoneNumber,
      'from_address': fromAddress,
      'to_address': toAddress,
      'from_zip_code': fromZipCode,
      'to_zip_code': toZipCode,
      'pickup_date': pickupDate,
      'distance': distance,
      'status': status,
      'vehicle_type': vehicleType,
      'weight_in_kg': weightInKg,
      'available_times': availableTimes?.map((e) => e.toJson()).toList(),
      'images': images,
      'customer': customer?.toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'vehicle_type_id': vehicleTypeId,
    };
  }
}

class AvailableTimes {
  String? fromTime;
  String? toTime;

  AvailableTimes({this.fromTime, this.toTime});

  factory AvailableTimes.fromJson(Map<String, dynamic> json) {
    return AvailableTimes(fromTime: json['from_time'], toTime: json['to_time']);
  }

  Map<String, dynamic> toJson() {
    return {'from_time': fromTime, 'to_time': toTime};
  }
}

class Customer {
  int? id;
  String? phone;
  String? name;
  String? email;
  String? profileImage;

  Customer({this.id, this.phone, this.name, this.email, this.profileImage});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      phone: json['phone'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
      'email': email,
      'profile_image': profileImage,
    };
  }
}
