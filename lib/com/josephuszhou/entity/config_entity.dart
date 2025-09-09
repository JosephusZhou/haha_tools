class AppConfigEntity {
  // 3des encrypt params config list
  List<TripleDesConfigEntity> tripleDesConfigList;

  // 3des encrypt params config list
  List<TripleDesConfigEntity> aesConfigList;

  // Android res dir
  String androidResDir;

  // Android res dir
  String harmonyResDir;

  AppConfigEntity(this.tripleDesConfigList, this.aesConfigList, this.androidResDir, this.harmonyResDir);

  AppConfigEntity.fromJson(Map<String, dynamic> json)
      : tripleDesConfigList = json["tripleDesConfigList"] == null
            ? []
            : List<TripleDesConfigEntity>.from(json["tripleDesConfigList"]
                .map((e) => TripleDesConfigEntity.fromJson(e))),
        aesConfigList = json["aesConfigList"] == null
            ? []
            : List<TripleDesConfigEntity>.from(json["aesConfigList"]
            .map((e) => TripleDesConfigEntity.fromJson(e))),
        androidResDir = json["androidResDir"] == null
            ? ""
            : json["androidResDir"] as String,
        harmonyResDir = json["harmonyResDir"] == null
            ? ""
            : json["harmonyResDir"] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "tripleDesConfigList": tripleDesConfigList,
        "aesConfigList": aesConfigList,
        "androidResDir": androidResDir,
        "harmonyResDir": harmonyResDir,
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
