import 'package:flutter/material.dart';

class ProductosModel {
  var id;

  String name;
  String image;
  int price;
  int quantity;

  ProductosModel(
    String documentID,
    String name,
    String image,
    int price,
    int quantity,
  );

  ProductosModel.map(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.image = obj['image'];
    this.price = obj['price'];
    this.quantity = obj['quantity'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['price'] = price;
    map['quantity'] = quantity;

    return map;
  }

  ProductosModel.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.id = map['id'];
    this.image = map['image'];
    this.price = map['price'];
    this.quantity = 0;
  }
}
