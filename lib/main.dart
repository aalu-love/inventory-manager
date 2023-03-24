import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:csv/csv.dart';

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
  List<List<dynamic>> _filteredData = [];
  List<List<dynamic>> _catagoryList = [];

  final TextEditingController _searchController = TextEditingController();
  String _sortValue = 'Name';

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/appsheet.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    setState(() {
      _data = _listData;
    });
  }

  void _filterData(String query) {
    List<List<dynamic>> _newList = [];
    _data.forEach((row) {
      if (row[6].toString().toLowerCase().contains(query.toLowerCase())) {
        _newList.add(row);
      }
      if (row[2].toString().toLowerCase().contains(query.toLowerCase())) {
        _newList.add(row);
      }
    });
    setState(() {
      _filteredData = _newList;
    });
  }

  void _CatalogList(String catalog) {
    List<List<dynamic>> _catalogList = [];
    _data.forEach((row) {
      if (row[1].toString().toLowerCase().contains(catalog.toLowerCase())) {
        _catagoryList.add(row);
      }
    });
  }

    void _sortData(String sortValue) {
    setState(() {
      _sortValue = sortValue;
      _filteredData.sort((a, b) => a[1].compareTo(b[1]));
      if (sortValue == 'Reverse Name') {
        _filteredData = _filteredData.reversed.toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kindacode.com"),
        actions: [
          IconButton(
            onPressed: () {
              _searchController.clear();
              _filterData('');
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 4,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      _filterData(query);
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                    ),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 2,
                  child: DropdownButton<String>(
                    value: _sortValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                    onChanged: (String? newValue) {
                      _sortData(newValue!);
                    },
                    items: <String>[
                      'Name',
                      'Reverse Name',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredData.length,
              itemBuilder: (_, index) {
                return Card(
                  margin: const EdgeInsets.all(3),
                  color: index == 0 ? Colors.amber : Colors.white,
                  child: ListTile(
                    leading: Text(_filteredData[index][0].toString()),
                    title: Text(_filteredData[index][1]),
                    trailing: Text(_filteredData[index][2].toString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _loadCSV, child: const Icon(Icons.add)),
    );
  }
}
