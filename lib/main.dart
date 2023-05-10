import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:csv/csv.dart';
import 'package:flutter_application_1/components/card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<dynamic>> _data = [];
  // List<List<dynamic>> _filteredData = [];
  // List<List<dynamic>> _catagoryList = [];

  // final TextEditingController _searchController = TextEditingController();
  // String _sortValue = 'Name';

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/appsheet.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    setState(() {
      _data = _listData;
    });
  }

  // void _filterData(String query) {
  //   List<List<dynamic>> _newList = [];
  //   _data.forEach((row) {
  //     if (row[6].toString().toLowerCase().contains(query.toLowerCase())) {
  //       _newList.add(row);
  //     }
  //     if (row[2].toString().toLowerCase().contains(query.toLowerCase())) {
  //       _newList.add(row);
  //     }
  //   });
  //   setState(() {
  //     _filteredData = _newList;
  //   });
  // }

  // void _CatalogList(String catalog) {
  //   List<List<dynamic>> _catalogList = [];
  //   _data.forEach((row) {
  //     if (row[1].toString().toLowerCase().contains(catalog.toLowerCase())) {
  //       _catagoryList.add(row);
  //     }
  //   });
  // }

  // void _sortData(String sortValue) {
  //   setState(() {
  //     _sortValue = sortValue;
  //     _filteredData.sort((a, b) => a[1].compareTo(b[1]));
  //     if (sortValue == 'Reverse Name') {
  //       _filteredData = _filteredData.reversed.toList();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kindacode.com"),
      ),
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       ),
      //     ),
      //     Expanded(
      //       child: ListView.builder(
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
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          Expanded(child: ListView.builder(itemBuilder: (_, index) {
            return const SizedBox(
              child: Text(_data[0][index], key: Int(index), ),
            )
            // return Card(
            //   margin: const EdgeInsets.all(3),
            //   color: index == 0 ? Colors.amber : Colors.white,
            //   child: ListTile(
            //     leading: Text(
            //       _data[index][0].toString(),
            //     ),
            //     title: Text(
            //       _data[index][1],
            //       overflow: TextOverflow.ellipsis,
            //       textAlign: TextAlign.left,
            //     ),
            //     trailing: Text(
            //       _data[index][2].toString(),
            //       overflow: TextOverflow.ellipsis,
            //     ),
            //     minLeadingWidth: 50,
            //   ),
            // );
          })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _loadCSV, child: const Icon(Icons.add)),
    );
  }
}
