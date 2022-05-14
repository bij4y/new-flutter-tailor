// To parse required this JSON data, do
//
//     final carouselModel = carouselModelFromJson(jsonString);

import 'dart:convert';

CarouselModel carouselModelFromJson(String str) =>
    CarouselModel.fromJson(json.decode(str));

String carouselModelToJson(CarouselModel data) => json.encode(data.toJson());

class CarouselModel {
  CarouselModel({
    required this.data,
  });

  List<Datum> data;

  factory CarouselModel.fromJson(Map<String, dynamic> json) => CarouselModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.feature,
  });

  int id;
  String feature;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        feature: json["feature"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "feature": feature,
      };
}
