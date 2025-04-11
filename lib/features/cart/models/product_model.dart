// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
  json.decode(str).map((x) => ProductModel.fromJson(x)),
);

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  String? id;
  String? name;
  String? price;
  int? v;
  bool? alreadyInCart;
  int? count;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.v,
    this.alreadyInCart,
    this.count,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["_id"],
    name: json["name"],
    price: json["price"],
    v: json["__v"],
    alreadyInCart: json["alreadyInCart"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "price": price,
    "__v": v,
    "alreadyInCart": alreadyInCart,
    "count": count,
  };
}
