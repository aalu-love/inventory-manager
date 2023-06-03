import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../models/item.dart';

class CsvService {
  Future<List<Item>> fetchItemsFromCSV() async {
    final String csvData = await rootBundle.loadString('assets/appsheet.csv');
    final List<List<dynamic>> csvTable =
        const CsvToListConverter().convert(csvData);

    List<Item> items = [];
    for (final row in csvTable) {
      final item = Item(
        name: row[0],
        category: row[1],
      );
      items.add(item);
    }

    return items;
  }
}
