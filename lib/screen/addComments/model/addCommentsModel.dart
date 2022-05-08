class AddCommentsModel {
  List<Data> data;
  String success;
  int status;

  AddCommentsModel({this.data, this.success, this.status});

  AddCommentsModel.fromJson(Map<String, dynamic> json) {
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
  String hospitalId;
  String comment;
  int upvotes;
  int downvotes;
  String updatedAt;
  String createdAt;
  int id;

  Data(
      {this.userId,
        this.hospitalId,
        this.comment,
        this.upvotes,
        this.downvotes,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    hospitalId = json['hospital_id'];
    comment = json['comment'];
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['hospital_id'] = this.hospitalId;
    data['comment'] = this.comment;
    data['upvotes'] = this.upvotes;
    data['downvotes'] = this.downvotes;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
