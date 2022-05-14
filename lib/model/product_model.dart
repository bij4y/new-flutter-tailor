// To parse required this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.data,
  });

  List<Datum> data;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.sku,
    required this.name,
    required this.image,
    required this.sp,
    required this.description,
    required this.categoryId,
    required this.category,
    required this.address,
    required this.contact,
    required this.logo,
    required this.rating,
    required this.userId,
    required this.qty,
  });

  int id;
  dynamic sku;
  String name;
  String image;
  int sp;
  String description;
  int categoryId;
  String category;
  String address;
  String contact;
  String logo;
  Rating rating;
  String userId;
  int qty;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sku: json["sku"],
        name: json["name"],
        image: json["image"],
        sp: json["sp"],
        description: json["description"],
        categoryId: json["category_id"],
        category: json["category"],
        address: json["address"],
        contact: json["contact"],
        logo: json["logo"],
        rating: Rating.fromJson(json["rating"]),
        userId: json["user_id"],
        qty: 1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "name": name,
        "image": image,
        "sp": sp,
        "description": description,
        "category_id": categoryId,
        "category": category,
        "address": address,
        "contact": contact,
        "logo": logo,
        "rating": rating.toJson(),
        "user_id": userId,
        "qty": qty
      };
}

class Rating {
  Rating({
    required this.rating,
  });

  String rating;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
      };
}
