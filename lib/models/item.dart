import 'dart:convert';

class Item {
  final String id;
  final String uom;
  final String binNo;
  final String valStock;
  final String maxPrice;
  final String materialNo;
  final String description;
  final String storageLoc;

  Item({
    required this.id,
    required this.uom,
    required this.binNo,
    required this.valStock,
    required this.maxPrice,
    required this.materialNo,
    required this.description,
    required this.storageLoc,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'].toString(),
      uom: json['uom'].toString(),
      binNo: json['binNo.'].toString(),
      valStock: json['valStock'].toString(),
      maxPrice: json['maxPrice'].toString(),
      materialNo: json['material no.'].toString(),
      description: json['description'].toString(),
      storageLoc: json['storageLoc'].toString(),
    );
  }
}

List<Item> parseItems(String jsonString) {
  List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((data) => Item.fromJson(data)).toList();
}
