class SearchModel {
  Datum datum;
  int countHospitals;
  int status;

  SearchModel({this.datum, this.countHospitals, this.status});

  SearchModel.fromJson(Map<String, dynamic> json) {
    datum = json['datum'] != null ? new Datum.fromJson(json['datum']) : null;
    countHospitals = json['count_hospitals'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datum != null) {
      data['datum'] = this.datum.toJson();
    }
    data['count_hospitals'] = this.countHospitals;
    data['status'] = this.status;
    return data;
  }
}

class Datum {
  Hospitals hospitals;

  Datum({this.hospitals});

  Datum.fromJson(Map<String, dynamic> json) {
    hospitals = json['hospitals'] != null
        ? new Hospitals.fromJson(json['hospitals'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hospitals != null) {
      data['hospitals'] = this.hospitals.toJson();
    }
    return data;
  }
}

class Hospitals {
  int currentPage;
  List<Data> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  Hospitals(
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

  Hospitals.fromJson(Map<String, dynamic> json) {
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
  String hospitalId;
  String hospitalName;
  String hospitalAddress;
  String googleMapLocation;
  String phoneNumber1;
  String phoneNumber2;
  String source;
  String image;
  String contributor;
  String hospitalResourceId;
  String bedOxygen;
  String bedWoOxygen;
  String bedWoIcu;
  String bedIcu;
  String bedVentilator;
  String bloodBank;
  String availBedOxygen;
  String availBedWoOxygen;
  String availBedWoIcu;
  String availBedIcu;
  String availBedVentilator;
  String availBloodBank;
  String pocName;
  String pocNumber;
  String pocDesg;
  String userId;
  String userName;
  String userEmail;
  String userType;
  String userPhone;
  String locationId;
  String pincode;
  String countryName;
  String stateName;
  String cityName;
  bool isSaved;
  int isUpVotedPhoneNumber1;
  int isUpVotedPhoneNumber2;
  int isDownVotedPhoneNumber1;
  int isDownVotedPhoneNumber2;
  bool isUpvoted;
  bool isDownvoted;

  Data(
      {this.hospitalId,
        this.hospitalName,
        this.hospitalAddress,
        this.googleMapLocation,
        this.phoneNumber1,
        this.phoneNumber2,
        this.source,
        this.image,
        this.contributor,
        this.hospitalResourceId,
        this.bedOxygen,
        this.bedWoOxygen,
        this.bedWoIcu,
        this.bedIcu,
        this.bedVentilator,
        this.bloodBank,
        this.availBedOxygen,
        this.availBedWoOxygen,
        this.availBedWoIcu,
        this.availBedIcu,
        this.availBedVentilator,
        this.availBloodBank,
        this.pocName,
        this.pocNumber,
        this.pocDesg,
        this.userId,
        this.userName,
        this.userEmail,
        this.userType,
        this.userPhone,
        this.locationId,
        this.pincode,
        this.countryName,
        this.stateName,
        this.cityName,
        this.isSaved,
        this.isUpVotedPhoneNumber1,
        this.isUpVotedPhoneNumber2,
        this.isDownVotedPhoneNumber1,
        this.isDownVotedPhoneNumber2,
        this.isUpvoted,
        this.isDownvoted});

  Data.fromJson(Map<String, dynamic> json) {
    hospitalId = json['hospital_id'];
    hospitalName = json['hospital_name'];
    hospitalAddress = json['hospital_address'];
    googleMapLocation = json['google_map_location'];
    phoneNumber1 = json['phone_number_1'];
    phoneNumber2 = json['phone_number_2'];
    source = json['source'];
    image = json['image'];
    contributor = json['contributor'];
    hospitalResourceId = json['hospital_resource_id'];
    bedOxygen = json['bed_oxygen'];
    bedWoOxygen = json['bed_wo_oxygen'];
    bedWoIcu = json['bed_wo_icu'];
    bedIcu = json['bed_icu'];
    bedVentilator = json['bed_ventilator'];
    bloodBank = json['blood_bank'];
    availBedOxygen = json['avail_bed_oxygen'];
    availBedWoOxygen = json['avail_bed_wo_oxygen'];
    availBedWoIcu = json['avail_bed_wo_icu'];
    availBedIcu = json['avail_bed_icu'];
    availBedVentilator = json['avail_bed_ventilator'];
    availBloodBank = json['avail_blood_bank'];
    pocName = json['poc_name'];
    pocNumber = json['poc_number'];
    pocDesg = json['poc_desg'];
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userType = json['user_type'];
    userPhone = json['user_phone'];
    locationId = json['location_id'];
    pincode = json['pincode'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    cityName = json['city_name'];
    isSaved = json['is_saved'];
    isUpVotedPhoneNumber1 = json['is_upVoted_phoneNumber1'];
    isUpVotedPhoneNumber2 = json['is_upVoted_phoneNumber2'];
    isDownVotedPhoneNumber1 = json['is_downVoted_phoneNumber1'];
    isDownVotedPhoneNumber2 = json['is_downVoted_phoneNumber2'];
    isUpvoted = json['is_upvoted'];
    isDownvoted = json['is_downvoted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospital_id'] = this.hospitalId;
    data['hospital_name'] = this.hospitalName;
    data['hospital_address'] = this.hospitalAddress;
    data['google_map_location'] = this.googleMapLocation;
    data['phone_number_1'] = this.phoneNumber1;
    data['phone_number_2'] = this.phoneNumber2;
    data['source'] = this.source;
    data['image'] = this.image;
    data['contributor'] = this.contributor;
    data['hospital_resource_id'] = this.hospitalResourceId;
    data['bed_oxygen'] = this.bedOxygen;
    data['bed_wo_oxygen'] = this.bedWoOxygen;
    data['bed_wo_icu'] = this.bedWoIcu;
    data['bed_icu'] = this.bedIcu;
    data['bed_ventilator'] = this.bedVentilator;
    data['blood_bank'] = this.bloodBank;
    data['avail_bed_oxygen'] = this.availBedOxygen;
    data['avail_bed_wo_oxygen'] = this.availBedWoOxygen;
    data['avail_bed_wo_icu'] = this.availBedWoIcu;
    data['avail_bed_icu'] = this.availBedIcu;
    data['avail_bed_ventilator'] = this.availBedVentilator;
    data['avail_blood_bank'] = this.availBloodBank;
    data['poc_name'] = this.pocName;
    data['poc_number'] = this.pocNumber;
    data['poc_desg'] = this.pocDesg;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_type'] = this.userType;
    data['user_phone'] = this.userPhone;
    data['location_id'] = this.locationId;
    data['pincode'] = this.pincode;
    data['country_name'] = this.countryName;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    data['is_saved'] = this.isSaved;
    data['is_upVoted_phoneNumber1'] = this.isUpVotedPhoneNumber1;
    data['is_upVoted_phoneNumber2'] = this.isUpVotedPhoneNumber2;
    data['is_downVoted_phoneNumber1'] = this.isDownVotedPhoneNumber1;
    data['is_downVoted_phoneNumber2'] = this.isDownVotedPhoneNumber2;
    data['is_upvoted'] = this.isUpvoted;
    data['is_downvoted'] = this.isDownvoted;
    return data;
  }
}
