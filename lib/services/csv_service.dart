import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../models/item.dart';

class CsvService {
  Future<List<Item>> fetchItemsFromCSV() async {
    final String csvData = await rootBundle.loadString('assets/appsheet.csv');
    final List<List<dynamic>> csvTable =
        const CsvToListConverter().convert(csvData);

    final items = csvTable
        .skip(1)
        .map((row) => Item(
              name: row[0].toString(),
              category: row[1].toString(),
            ))
        .toList();

    return items;
  }
}
