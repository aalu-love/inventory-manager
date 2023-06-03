import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/item.dart';
import 'package:flutter_application_1/screens/detail_screen.dart';
import 'package:flutter_application_1/services/csv_service.dart';
import 'package:flutter_application_1/widgets/item_card.dart';

class HomeScreen extends StatelessWidget {
  final CsvService csvService = CsvService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder<List<Item>>(
        future: csvService.fetchItemsFromCSV(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(item: items[index]),
                      ),
                    );
                  },
                  child: ItemCard(item: items[index]),
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
      ),
    );
  }
}
