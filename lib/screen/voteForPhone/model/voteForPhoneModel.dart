class VoteForPhoneModel {
  Datum datum;
  int status;

  VoteForPhoneModel({this.datum, this.status});

  VoteForPhoneModel.fromJson(Map<String, dynamic> json) {
    datum = json['datum'] != null ? new Datum.fromJson(json['datum']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datum != null) {
      data['datum'] = this.datum.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Datum {
  String msg;

  Datum({this.msg});

  Datum.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    return data;
  }
}
