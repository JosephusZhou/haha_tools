class AppConfigEntity {
  // 3des encrypt params config list
  List<TripleDesConfigEntity> tripleDesConfigList;

  // Android res dir
  String androidResDir;

  AppConfigEntity(this.tripleDesConfigList, this.androidResDir);

  AppConfigEntity.fromJson(Map<String, dynamic> json)
      : tripleDesConfigList = json["tripleDesConfigList"] == null
            ? []
            : List<TripleDesConfigEntity>.from(json["tripleDesConfigList"]
                .map((e) => TripleDesConfigEntity.fromJson(e))),
        androidResDir = json["androidResDir"] == null
            ? ""
            : json["androidResDir"] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "tripleDesConfigList": tripleDesConfigList,
        "androidResDir": androidResDir
      };
}

class TripleDesConfigEntity {
  String name;
  String key;
  String iv;

  TripleDesConfigEntity(this.name, this.key, this.iv);

  TripleDesConfigEntity.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        key = json["key"] as String,
        iv = json["iv"] as String;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{"name": name, "key": key, "iv": iv};
}
