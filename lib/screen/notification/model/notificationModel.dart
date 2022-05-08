class NotificationModel {
  List<Data> data;
  int count;
  int status;

  NotificationModel({this.data, this.count, this.status});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    count = json['count'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String id;
  String userId;
  String pincode;
  String districtId;
  String age;
  String vaccine;
  String dose;
  String dateVaccine;
  String status;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.userId,
        this.pincode,
        this.districtId,
        this.age,
        this.vaccine,
        this.dose,
        this.dateVaccine,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    pincode = json['pincode'];
    districtId = json['district_id'];
    age = json['age'];
    vaccine = json['vaccine'];
    dose = json['dose'];
    dateVaccine = json['date_vaccine'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['pincode'] = this.pincode;
    data['district_id'] = this.districtId;
    data['age'] = this.age;
    data['vaccine'] = this.vaccine;
    data['dose'] = this.dose;
    data['date_vaccine'] = this.dateVaccine;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
