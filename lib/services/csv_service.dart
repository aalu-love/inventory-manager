import 'dart:developer';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CsvService {
  Future<List<Item>> fetchItemsFromCSV() async {
    final bool fileExists = await checkCsvFileExistence();

    if (fileExists) {
      final String csvData = await loadCsvFile();
      final List<List<dynamic>> csvTable =
          const CsvToListConverter().convert(csvData);
      final List<Item> items = processCsvData(csvTable);
      return items;
    } else {
      final String? filePath = await openFilePicker();

      if (filePath != null) {
        final String csvData = await readFile(filePath);
        final List<List<dynamic>> csvTable =
            const CsvToListConverter().convert(csvData);
        final List<Item> items = processCsvData(csvTable);
        return items;
      } else {
        return []; // Return an empty list if file path is null
      }
    }
  }

  Future<bool> checkCsvFileExistence() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File(path.join(directory.path, 'appsheet.csv'));
    return file.exists();
  }

  Future<String> loadCsvFile() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/appsheet.csv');
    return await file.readAsString();
  }

  Future<String?> openFilePicker() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null && result.files.isNotEmpty) {
      final String filePath = result.files.single.path!;
      final Directory directory = await getApplicationDocumentsDirectory();
      final String destinationPath = path.join(directory.path, 'appsheet.csv');

      try {
        await File(filePath).copy(destinationPath);
        return destinationPath;
      } catch (e) {
        log('Error copying file: $e');
        return null;
      }
    }
    return null;
  }

  Future<String> readFile(String filePath) async {
    final File file = File(filePath);
    return await file.readAsString();
  }

  List<Item> processCsvData(List<List<dynamic>> csvTable) {
    const int materialNo = 0;
    const int desription = 1;
    const int binNo = 2;
    const int valueStock = 3;
    const int avgPrice = 4;
    const int value = 5;
    const int uom = 6;
    const int storageLoc = 7;
    final List<Item> items = csvTable.skip(1).map((row) {
      return Item(
        materialNo: row[materialNo].toString(),
        desription: row[desription].toString(),
        binNo: row[binNo].toString(),
        valueStock: row[valueStock].toString(),
        avgPrice: row[avgPrice].toString(),
        value: row[value].toString(),
        uom: row[uom].toString(),
        storageLoc: row[storageLoc].toString(),
        // Add any other properties as required based on your CSV file structure
      );
    }).toList();
    return items;
  }
}
