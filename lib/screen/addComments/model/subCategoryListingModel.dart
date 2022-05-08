class SubCategoryListingModel {
  List<Data> data;
  int count;
  int status;

  SubCategoryListingModel({this.data, this.count, this.status});

  SubCategoryListingModel.fromJson(Map<String, dynamic> json) {
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
  String subcategoryName;

  Data({this.id, this.subcategoryName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcategoryName = json['subcategory_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subcategory_name'] = this.subcategoryName;
    return data;
  }
}
