

class SwitchDetailModel {
  int? errCode;
  SwitchDetailModelDetail? detail;

  SwitchDetailModel({this.errCode, this.detail});

  SwitchDetailModel.fromJson(Map<String, dynamic> json) {
    errCode = json['errcode'];
    detail =
    json['detail'] != null ? SwitchDetailModelDetail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errcode'] = errCode;
    if (detail != null) {
      data['detail'] = detail!.toJson();
    }
    return data;
  }
}

class SwitchDetailModelDetail {
  String? note;
  List<String>? tx;
  List<String>? rx;
  String? ip;
  List<String>? pw;
  List<int>? link;
  List<int>? poEc;
  String? mac;
  int? iSoc;
  String? uptime;
  String? vol;
  List<String>? portNote;
  String? v;
  List<int>? snr;
  List<int>? phYc;
  String? name;
  String? tp;

  SwitchDetailModelDetail(
      {this.note,
        this.tx,
        this.rx,
        this.ip,
        this.pw,
        this.link,
        this.poEc,
        this.mac,
        this.iSoc,
        this.uptime,
        this.vol,
        this.portNote,
        this.v,
        this.snr,
        this.phYc,
        this.name,
        this.tp});

  SwitchDetailModelDetail.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    tx = json['tx'].cast<String>();
    rx = json['rx'].cast<String>();
    ip = json['ip'];
    pw = json['pw'].cast<String>();
    link = json['link'].cast<int>();
    poEc = json['poec'].cast<int>();
    mac = json['mac'];
    iSoc = json['isoc'];
    uptime = json['uptime'];
    vol = json['vol'];
    portNote = json['portNote'].cast<String>();
    v = json['V'];
    snr = json['snr'].cast<int>();
    phYc = json['phyc'].cast<int>();
    name = json['name'];
    tp = json['tp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note'] = note;
    data['tx'] = tx;
    data['rx'] = rx;
    data['ip'] = ip;
    data['pw'] = pw;
    data['link'] = link;
    data['poec'] = poEc;
    data['mac'] = mac;
    data['isoc'] = iSoc;
    data['uptime'] = uptime;
    data['vol'] = vol;
    data['portNote'] = portNote;
    data['V'] = v;
    data['snr'] = snr;
    data['phyc'] = phYc;
    data['name'] = name;
    data['tp'] = tp;
    return data;
  }
}
