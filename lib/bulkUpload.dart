// import 'dart:convert';
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show SystemUiOverlayStyle, rootBundle;
// import 'package:csv/csv.dart';

// class _HomePageState extends State<HomePage> {
//   List<List<dynamic>> _data = [];

//   // This function is triggered when the floating button is pressed
//   void _loadCSV() async {
//     final _rawData = await rootBundle.loadString("assets/kindacode.csv");
//     List<List<dynamic>> _listData =
//         const CsvToListConverter().convert(_rawData);
//     setState(() {
//       _data = _listData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Kindacode.com"),
//       ),
//       // Display the contents from the CSV file
//       body: ListView.builder(
//         itemCount: _data.length,
//         itemBuilder: (_, index) {
//           return Card(
//             margin: const EdgeInsets.all(3),
//             color: index == 0 ? Colors.amber : Colors.white,
//             child: ListTile(
//               leading: Text(_data[index][0].toString()),
//               title: Text(_data[index][1]),
//               trailing: Text(_data[index][2].toString()),
//             ),
//           );
//         },
//       ),

//       floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add), onPressed: _loadCSV),
//     );
//   }
// }