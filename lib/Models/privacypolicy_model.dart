class PrivacyPolicyModel {
  String? message;
  List<Data>? data;

  PrivacyPolicyModel({this.message, this.data});

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;

  Data({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.title,
    this.description,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_active'] = isActive;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
