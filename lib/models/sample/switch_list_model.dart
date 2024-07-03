class SwitchListModel {
  int? errCode;
  String? note;
  List<SwitchListModelOffline>? offline;
  String? name;
  List<SwitchListModelOnline>? online;

  SwitchListModel({this.errCode, this.note, this.offline, this.name, this.online});

  SwitchListModel.fromJson(Map<String, dynamic> json) {
    errCode = json['errcode'];
    note = json['note'];
    if (json['offline'] != null) {
      offline = <SwitchListModelOffline>[];
      json['offline'].forEach((v) {
        offline!.add(SwitchListModelOffline.fromJson(v));
      });
    }
    name = json['name'];
    if (json['online'] != null) {
      online = <SwitchListModelOnline>[];
      json['online'].forEach((v) {
        online!.add(SwitchListModelOnline.fromJson(v));
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

class SwitchListModelOffline {
  String? note;
  String? v;
  String? name;
  String? sn;
  String? mac;

  SwitchListModelOffline({this.note, this.v, this.name, this.sn, this.mac});

  SwitchListModelOffline.fromJson(Map<String, dynamic> json) {
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

class SwitchListModelOnline {
  String? note;
  String? activeState;
  List<int>? snr;
  String? v;
  List<String>? pw;
  List<int>? link;
  String? name;
  String? sn;
  String? mac;

  SwitchListModelOnline({this.note, this.activeState, this.snr, this.v, this.pw, this.link, this.name, this.sn, this.mac});

  SwitchListModelOnline.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    activeState = json['Active_state'];
    snr = json['snr'].cast<int>();
    v = json['V'];
    pw = json['pw'].cast<String>();
    link = json['link'].cast<int>();
    name = json['name'];
    sn = json['sn'];
    mac = json['mac'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note'] = note;
    data['Active_state'] = activeState;
    data['snr'] = snr;
    data['V'] = v;
    data['pw'] = pw;
    data['link'] = link;
    data['name'] = name;
    data['sn'] = sn;
    data['mac'] = mac;
    return data;
  }
}
