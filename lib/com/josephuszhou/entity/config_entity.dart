class AppConfigEntity {
  List<TripleDesConfigEntity> tripleDesConfigList;

  AppConfigEntity(this.tripleDesConfigList);

  AppConfigEntity.fromJson(Map<String, dynamic> json)
      : tripleDesConfigList = json["tripleDesConfigList"] == null
            ? []
            : List<TripleDesConfigEntity>.from(json["tripleDesConfigList"]
                .map((e) => TripleDesConfigEntity.fromJson(e)));

  Map<String, dynamic> toJson() =>
      <String, dynamic>{"tripleDesConfigList": tripleDesConfigList};
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
