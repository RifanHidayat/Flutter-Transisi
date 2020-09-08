// To parse this JSON data, do
//
//     final detailMeals = detailMealsFromJson(jsonString);

import 'dart:convert';

DetailMeals detailMealsFromJson(String str) => DetailMeals.fromJson(json.decode(str));

String detailMealsToJson(DetailMeals data) => json.encode(data.toJson());

class DetailMeals {
  List<Map<String, String>> data;

  DetailMeals({
    this.data,
  });

  factory DetailMeals.fromJson(Map<String, dynamic> json) => DetailMeals(
    data: List<Map<String, String>>.from(json["data"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
  };
}