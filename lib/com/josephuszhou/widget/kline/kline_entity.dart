class LineData {
  List<KLineEntity> lineData;

  LineData.fromJson(Map<String, dynamic> json)
      : lineData = json["lineData"] == null
            ? []
            : List<KLineEntity>.from(
                json["lineData"].map((e) => KLineEntity.fromJson(e)));
}

class KLineEntity {
  int startTime;
  int endTime;
  double open;
  double high;
  double low;
  double close;
  double prevClose;
  double vol;
  double val;
  String upDown;
  String upDownRate;

  KLineEntity(
      this.startTime,
      this.endTime,
      this.open,
      this.high,
      this.low,
      this.close,
      this.prevClose,
      this.vol,
      this.val,
      this.upDown,
      this.upDownRate);

  KLineEntity.fromJson(Map<String, dynamic> json)
      : startTime = int.parse(json["startTime"] as String),
        endTime = int.parse(json["endTime"] as String),
        open = double.parse(json["open"] as String),
        high = double.parse(json["high"] as String),
        low = double.parse(json["low"] as String),
        close = double.parse(json["close"] as String),
        prevClose = double.parse(json["prevClose"] as String),
        vol = double.parse(json["vol"] as String),
        val = double.parse(json["val"] as String),
        upDown = json["upDown"] as String,
        upDownRate = json["upDownRate"] as String;
}
