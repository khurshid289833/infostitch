class NotifyUserModel {
  List<Data> data;
  String success;
  int status;

  NotifyUserModel({this.data, this.success, this.status});

  NotifyUserModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int userId;
  String pincode;
  String districtId;
  Null age;
  Null vaccine;
  Null dose;
  String dateVaccine;
  String updatedAt;
  String createdAt;
  int id;

  Data(
      {this.userId,
        this.pincode,
        this.districtId,
        this.age,
        this.vaccine,
        this.dose,
        this.dateVaccine,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    pincode = json['pincode'];
    districtId = json['district_id'];
    age = json['age'];
    vaccine = json['vaccine'];
    dose = json['dose'];
    dateVaccine = json['date_vaccine'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['pincode'] = this.pincode;
    data['district_id'] = this.districtId;
    data['age'] = this.age;
    data['vaccine'] = this.vaccine;
    data['dose'] = this.dose;
    data['date_vaccine'] = this.dateVaccine;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
