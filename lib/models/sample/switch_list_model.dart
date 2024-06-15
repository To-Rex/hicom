class SwitchListModel {
  int? errCode;
  String? note;
  List<Offline>? offline;
  String? name;
  List<Offline>? online;

  SwitchListModel({this.errCode, this.note, this.offline, this.name, this.online});

  SwitchListModel.fromJson(Map<String, dynamic> json) {
    errCode = json['errcode'];
    note = json['note'];
    if (json['offline'] != null) {
      offline = <Offline>[];
      json['offline'].forEach((v) {
        offline!.add(Offline.fromJson(v));
      });
    }
    name = json['name'];
    if (json['online'] != null) {
      online = <Offline>[];
      json['online'].forEach((v) {
        online!.add(Offline.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errcode'] = errCode;
    data['note'] = note;
    if (offline != null) {
      data['offline'] = offline!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    if (online != null) {
      data['online'] = online!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offline {
  String? note;
  String? v;
  String? name;
  String? sn;
  String? mac;

  Offline({this.note, this.v, this.name, this.sn, this.mac});

  Offline.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    v = json['V'];
    name = json['name'];
    sn = json['sn'];
    mac = json['mac'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note'] = note;
    data['V'] = v;
    data['name'] = name;
    data['sn'] = sn;
    data['mac'] = mac;
    return data;
  }
}
