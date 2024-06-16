class SettingsInfo {
  int? errCode;
  List<Settings>? settings;

  SettingsInfo({this.errCode, this.settings});

  SettingsInfo.fromJson(Map<String, dynamic> json) {
    errCode = json['errcode'];
    if (json['settings'] != null) {
      settings = <Settings>[];
      json['settings'].forEach((v) {
        settings!.add(Settings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errcode'] = errCode;
    if (settings != null) {
      data['settings'] = settings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Settings {
  String? name;
  String? value;

  Settings({this.name, this.value});

  Settings.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
