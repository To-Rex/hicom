class RegisterModel {
  int? errcode;
  String? uid;
  String? key;

  RegisterModel({this.errcode, this.uid, this.key});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    errcode = json['errcode'];
    uid = json['uid'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errcode'] = errcode;
    data['uid'] = uid;
    data['key'] = key;
    return data;
  }
}
