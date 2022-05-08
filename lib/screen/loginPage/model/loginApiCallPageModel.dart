class LoginApiCallPageModel {
  Data data;

  LoginApiCallPageModel({this.data});

  LoginApiCallPageModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String token;
  String timezone;
  User user;

  Data({this.token, this.timezone, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    timezone = json['timezone'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['timezone'] = this.timezone;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  String type;
  String phone;
  String profilePic;
  String deviceId;
  String createdAt;
  String updatedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.type,
        this.phone,
        this.profilePic,
        this.deviceId,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
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
