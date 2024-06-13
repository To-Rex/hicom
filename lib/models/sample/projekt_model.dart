class ProjectModel {
  int? errCode;
  List<Admin>? admin;
  List<Admin>? join;

  ProjectModel({this.errCode, this.admin, this.join});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    errCode = json['errcode'];
    if (json['admin'] != null) {
      admin = <Admin>[];
      json['admin'].forEach((v) {
        admin!.add(Admin.fromJson(v));
      });
    }
    if (json['join'] != null) {
      join = <Admin>[];
      json['join'].forEach((v) {
        join!.add(Admin.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errcode'] = errCode;
    if (admin != null) {
      data['admin'] = admin!.map((v) => v.toJson()).toList();
    }
    if (join != null) {
      data['join'] = join!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Admin {
  int? sc;
  String? note;
  int? wsc;
  String? name;
  String? pid;
  int? lsc;

  Admin({this.sc, this.note, this.wsc, this.name, this.pid, this.lsc});

  Admin.fromJson(Map<String, dynamic> json) {
    sc = json['sc'];
    note = json['note'];
    wsc = json['wsc'];
    name = json['name'];
    pid = json['pid'];
    lsc = json['lsc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sc'] = sc;
    data['note'] = note;
    data['wsc'] = wsc;
    data['name'] = name;
    data['pid'] = pid;
    data['lsc'] = lsc;
    return data;
  }
}
