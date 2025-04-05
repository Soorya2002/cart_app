// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  List<Item>? items;

  Cart({this.items});

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    items:
        json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items":
        items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  String? productId;
  String? name;
  String? price;
  int? quantity;

  Item({this.productId, this.name, this.price, this.quantity});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    productId: json["productId"],
    name: json["name"],
    price: json["price"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "name": name,
    "price": price,
    "quantity": quantity,
  };
}
