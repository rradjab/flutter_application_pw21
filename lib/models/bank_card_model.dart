import 'dart:convert';

class BankCardModel {
  String number;
  String expireDate;
  String cvv;

  BankCardModel(
      {required this.number, required this.expireDate, required this.cvv});

  factory BankCardModel.fromJson(Map<String, dynamic> json) {
    return BankCardModel(
        number: json['number'],
        expireDate: json['expireDate'],
        cvv: json['cvv']);
  }

  static Map<String, dynamic> toMap(BankCardModel model) => <String, dynamic>{
        'number': model.number,
        'expireDate': model.expireDate,
        'cvv': model.cvv,
      };

  static String serialize(BankCardModel model) =>
      json.encode(BankCardModel.toMap(model));

  static BankCardModel deserialize(String json) =>
      BankCardModel.fromJson(jsonDecode(json));
}
