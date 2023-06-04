import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/screens/detail_screen.dart';
import 'package:flutter_application_1/services/csv_service.dart';
import 'package:flutter_application_1/widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CsvService csvService = CsvService();
  List<Item> items = [];
  List<Item> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  bool isFileSelected = false; // Tracks if a file is selected or not

  @override
  void initState() {
    super.initState();
    fetchItemsFromCSV();
  }

  Future<void> fetchItemsFromCSV() async {
    final bool fileExists = await csvService.checkCsvFileExistence();

    if (fileExists) {
      final fetchedItems = await csvService.fetchItemsFromCSV();
      setState(() {
        items = fetchedItems;
        filteredItems = fetchedItems;
        isFileSelected = true;
      });
    } else {
      setState(() {
        isFileSelected = false;
      });
    }
  }

  void searchItems(String value) {
    setState(() {
      filteredItems = items
          .where((item) =>
              item.materialNo.toLowerCase().contains(value.toLowerCase()) ||
              item.desription.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      filteredItems = List.from(items);
    });
  }

  Future<void> openFilePicker() async {
    final filePath = await csvService.openFilePicker();
    if (filePath != null) {
      fetchItemsFromCSV();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                onChanged: searchItems,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white.withOpacity(0.8)),
                cursorColor: Colors.white.withOpacity(0.4),
                cursorWidth: 2,
              )
            : const Text(
                'Home',
                style: TextStyle(color: Colors.white, fontFamily: 'monospace'),
              ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
          ),
          if (isSearching)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  isSearching = false;
                  clearSearch();
                });
              },
            ),
        ],
      ),
      body: isFileSelected
          ? FutureBuilder<List<Item>>(
              future: csvService.fetchItemsFromCSV(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(item: filteredItems[index]),
                            ),
                          );
                        },
                        child: ItemCard(item: filteredItems[index]),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error fetching data'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No file selected.'),
                  ElevatedButton(
                    onPressed: openFilePicker,
                    child: const Text('Select File'),
                  ),
                ],
              ),
            ),
    );
  }
}
