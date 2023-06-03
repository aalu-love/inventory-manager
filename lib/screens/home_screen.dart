import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/screens/detail_screen.dart';
import 'package:flutter_application_1/services/csv_service.dart';
import 'package:flutter_application_1/widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CsvService csvService = CsvService();
  List<Item> items = [];
  List<Item> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    fetchItemsFromCSV();
  }

  Future<void> fetchItemsFromCSV() async {
    final fetchedItems = await csvService.fetchItemsFromCSV();

    setState(() {
      items = fetchedItems;
      filteredItems = List.from(items);
    });
  }

  void searchItems(String value) {
    setState(() {
      filteredItems = items
          .where((item) =>
              item.name.toLowerCase().contains(value.toLowerCase()) ||
              item.category.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      filteredItems = List.from(items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                onChanged: searchItems,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                  border: InputBorder.none,
                ),
              )
            : const Text('Home'),
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
      body: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          return InkWell(
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
      ),
    );
  }
}
