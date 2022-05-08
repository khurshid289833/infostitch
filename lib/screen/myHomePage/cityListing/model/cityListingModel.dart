class CityListingModel {
  List<Data> data;
  int count;
  int status;

  CityListingModel({this.data, this.count, this.status});

  CityListingModel.fromJson(Map<String, dynamic> json) {
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
  String stateName;
  String countryName;
  String cityName;

  Data({this.stateName, this.countryName, this.cityName});

  Data.fromJson(Map<String, dynamic> json) {
    stateName = json['state_name'];
    countryName = json['country_name'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_name'] = this.stateName;
    data['country_name'] = this.countryName;
    data['city_name'] = this.cityName;
    return data;
  }
}
