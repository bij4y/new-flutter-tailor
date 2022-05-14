// To parse required this JSON data, do
//
//     finalamount invoiceModel = invoiceModelFromJson(jsonString);

import 'dart:convert';

InvoiceModel invoiceModelFromJson(String str) =>
    InvoiceModel.fromJson(json.decode(str));

String invoiceModelToJson(InvoiceModel data) => json.encode(data.toJson());

class InvoiceModel {
  InvoiceModel({
    required this.data,
  });

  List<Datum> data;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.date,
    required this.userId,
    required this.total,
    required this.finalamount,
  });

  int id;
  DateTime date;
  int userId;
  int total;
  int finalamount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        userId: json["user_id"],
        total: json["total"],
        finalamount: json["finalamount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "user_id": userId,
        "total": total,
        "finalamount": finalamount,
      };
}
