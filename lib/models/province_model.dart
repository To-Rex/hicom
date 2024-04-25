class ProvinceModel {
  int? errcode;
  List<Regions>? regions;

  ProvinceModel({this.errcode, this.regions});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    errcode = json['errcode'];
    if (json['regions'] != null) {
      regions = <Regions>[];
      json['regions'].forEach((v) {
        regions!.add(Regions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errcode'] = errcode;
    if (regions != null) {
      data['regions'] = regions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Regions {
  int? id;
  int? countryId;
  String? name;

  Regions({this.id, this.countryId, this.name});

  Regions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_id'] = countryId;
    data['name'] = name;
    return data;
  }
}
