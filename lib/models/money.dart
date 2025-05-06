// ignore_for_file: unnecessary_new, prefer_collection_literals

class Money {
  int? moneyId;
  String? moneyDetail;
  String? moneyDate;
  double? moneyInOut;
  int? moneyType;
  int? userId;

  Money({
    this.moneyId,
    this.moneyDetail,
    this.moneyDate,
    this.moneyInOut,
    this.moneyType,
    this.userId,
  });

  Money.fromJson(Map<String, dynamic> json) {
    moneyId = json['moneyId'];
    moneyDetail = json['moneyDetail'];
    moneyDate = json['moneyDate'];
    moneyInOut = (json['moneyInOut'] as num?)?.toDouble();
    moneyType = json['moneyType'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moneyId'] = moneyId;
    data['moneyDetail'] = moneyDetail;
    data['moneyDate'] = moneyDate;
    data['moneyInOut'] = moneyInOut;
    data['moneyType'] = moneyType;
    data['userId'] = userId;
    return data;
  }
}
