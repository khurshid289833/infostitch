class HelplineNumberModel {
  Datum datum;
  int countHelplines;
  int status;

  HelplineNumberModel({this.datum, this.countHelplines, this.status});

  HelplineNumberModel.fromJson(Map<String, dynamic> json) {
    datum = json['datum'] != null ? new Datum.fromJson(json['datum']) : null;
    countHelplines = json['count_helplines'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datum != null) {
      data['datum'] = this.datum.toJson();
    }
    data['count_helplines'] = this.countHelplines;
    data['status'] = this.status;
    return data;
  }
}

class Datum {
  Helplines helplines;

  Datum({this.helplines});

  Datum.fromJson(Map<String, dynamic> json) {
    helplines = json['helplines'] != null
        ? new Helplines.fromJson(json['helplines'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.helplines != null) {
      data['helplines'] = this.helplines.toJson();
    }
    return data;
  }
}

class Helplines {
  int currentPage;
  List<Data> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  Null nextPageUrl;
  String path;
  int perPage;
  Null prevPageUrl;
  int to;
  int total;

  Helplines(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Helplines.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  String id;
  String phoneNumber;
  String details;
  String organizationName;
  String locationId;
  String pincode;
  String countryName;
  String stateName;
  String cityName;

  Data(
      {this.id,
        this.phoneNumber,
        this.details,
        this.organizationName,
        this.locationId,
        this.pincode,
        this.countryName,
        this.stateName,
        this.cityName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phone_number'];
    details = json['details'];
    organizationName = json['organization_name'];
    locationId = json['location_id'];
    pincode = json['pincode'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone_number'] = this.phoneNumber;
    data['details'] = this.details;
    data['organization_name'] = this.organizationName;
    data['location_id'] = this.locationId;
    data['pincode'] = this.pincode;
    data['country_name'] = this.countryName;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    return data;
  }
}
