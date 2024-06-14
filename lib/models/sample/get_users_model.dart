class GetUsersModel {
  int? errCode;
  List<Join>? join;

  GetUsersModel({this.errCode, this.join});

  GetUsersModel.fromJson(Map<String, dynamic> json) {
    errCode = json['errcode'];
    if (json['join'] != null) {
      join = <Join>[];
      json['join'].forEach((v) {
        join!.add(Join.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errcode'] = errCode;
    if (join != null) {
      data['join'] = join!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Join {
  String? uid;
  String? name;

  Join({this.uid, this.name});

  Join.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    return data;
  }
}
