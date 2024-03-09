import 'dart:typed_data';

import 'package:flutter/services.dart';

class Like {
  int id;
  String name;
  double price;
  Uint8List imageLink;

  Like({
    required this.id,
    required this.name,
    required this.price,
    required this.imageLink,
  });

  Like.fromMap({required map})
      : id = map["id"],
        name = map["name"] ?? "",
        price = map["price"] ?? "",
        imageLink = map['imageLink'] ?? "";

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "price": price, "imageLink": imageLink};
  }
}
