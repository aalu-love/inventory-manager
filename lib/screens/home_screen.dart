import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/api.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/widgets/item_card.dart';
import 'package:flutter_application_1/screens/detail_screen.dart';
import 'package:flutter_application_1/screens/loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> items = [];
  List<Item> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  late bool isLoading; // Tracks if a file is selected or not

  @override
  void initState() {
    super.initState();
    setLoadingState(true);
    fetchData();
  }

  void fetchData() {
    APIService.fetchData('/').then((response) {
      setData(response);
      setLoadingState(false);
    }).catchError((onError) {
      log(onError);
      setLoadingState(false);
    });
  }

  void setData(String data) {
    setState(() {
      items = parseItems(data);
      filteredItems = items;
    });
  }

  void searchItems(String value) {
    if (items.isNotEmpty) {
      setState(() {
        filteredItems = items
            .where((item) =>
                item.materialNo.toLowerCase().contains(value.toLowerCase()) ||
                item.description.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    }
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      filteredItems = List.from(items);
    });
  }

  setLoadingState(bool state) {
    setState(() {
      isLoading = state;
    });
  }

  Future refetch() async {
    setLoadingState(true);
    fetchData();
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'SAP STORE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Created by: Sanju Bodra',
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(
              child: LoadingScreen(),
            )
          : Scaffold(
              body: RefreshIndicator(
                onRefresh: refetch,
                child: items.isNotEmpty
                    ? ListView.builder(
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
                            child: items.isNotEmpty
                                ? ItemCard(item: filteredItems[index])
                                : const Center(child: Text("No items")),
                          );
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) => const Text(
                              "No items",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
    );
  }
}
