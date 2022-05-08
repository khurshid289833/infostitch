class ProfileUpdateModel {
  Data data;
  String success;
  int status;

  ProfileUpdateModel({this.data, this.success, this.status});

  ProfileUpdateModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int id;
  String name;
  String email;
  String type;
  String phone;
  String profilePic;
  String deviceId;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.type,
        this.phone,
        this.profilePic,
        this.deviceId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    type = json['type'];
    phone = json['phone'];
    profilePic = json['profile_pic'];
    deviceId = json['device_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['type'] = this.type;
    data['phone'] = this.phone;
    data['profile_pic'] = this.profilePic;
    data['device_id'] = this.deviceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
