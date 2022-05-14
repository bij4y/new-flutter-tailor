// To parse required this JSON data, do
//
//     final invoiceDetaiModel = invoiceDetaiModelFromJson(jsonString);

import 'dart:convert';

InvoiceDetaiModel invoiceDetaiModelFromJson(String str) =>
    InvoiceDetaiModel.fromJson(json.decode(str));

String invoiceDetaiModelToJson(InvoiceDetaiModel data) =>
    json.encode(data.toJson());

class InvoiceDetaiModel {
  InvoiceDetaiModel({
    required this.data,
  });

  List<Datum> data;

  factory InvoiceDetaiModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDetaiModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.total,
    required this.name,
    required this.sp,
    required this.qty,
    required this.image,
    required this.deliver,
    required this.categoryId,
  });

  int id;
  int total;
  String name;
  int sp;
  int qty;
  String image;
  int deliver;
  int categoryId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        total: json["total"],
        name: json["name"],
        sp: json["sp"],
        qty: json["qty"],
        image: json["image"],
        deliver: json["deliver"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "name": name,
        "sp": sp,
        "qty": qty,
        "image": image,
        "deliver": deliver,
        "category_id": categoryId,
      };
}
