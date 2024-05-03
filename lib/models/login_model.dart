class LoginModel {
  int? errcode;
  String? uid;
  String? key;
  User? user;

  LoginModel({this.errcode, this.uid, this.key, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    errcode = json['errcode'];
    uid = json['uid'];
    key = json['key'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errcode'] = errcode;
    data['uid'] = uid;
    data['key'] = key;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  int? type;
  String? phone;
  int? districtId;
  int? regionId;
  int? countryId;

  User(
      {this.id,
        this.name,
        this.type,
        this.phone,
        this.districtId,
        this.regionId,
        this.countryId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    phone = json['phone'];
    districtId = json['district_id'];
    regionId = json['region_id'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['phone'] = phone;
    data['district_id'] = districtId;
    data['region_id'] = regionId;
    data['country_id'] = countryId;
    return data;
  }
}
