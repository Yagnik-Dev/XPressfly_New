class DutyStatusResponseModel {
  bool? success;
  String? message;
  Data? data;

  DutyStatusResponseModel({this.success, this.message, this.data});

  DutyStatusResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  String? onDuty;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.userId, this.onDuty, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    onDuty = json['on_duty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['on_duty'] = onDuty;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
