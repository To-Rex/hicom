class DistrictsModel {
  int? errcode;
  List<Districts>? districts;

  DistrictsModel({this.errcode, this.districts});

  DistrictsModel.fromJson(Map<String, dynamic> json) {
    errcode = json['errcode'];
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts!.add(Districts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errcode'] = errcode;
    if (districts != null) {
      data['districts'] = districts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Districts {
  int? id;
  int? regionId;
  String? name;

  Districts({this.id, this.regionId, this.name});

  Districts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    regionId = json['region_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['region_id'] = regionId;
    data['name'] = name;
    return data;
  }
}
