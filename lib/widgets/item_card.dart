import '../models/item.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.materialNo),
        subtitle: Text(item.description),
      ),
    );
  }
}
