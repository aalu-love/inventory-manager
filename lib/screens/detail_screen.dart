import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/label_Item.dart';
import '../models/item.dart';

class DetailScreen extends StatefulWidget {
  final Item item;

  const DetailScreen({super.key, required this.item});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            LabelValueFormField(
              label: 'Name',
              initialValue: widget.item.name,
            ),
            LabelValueFormField(
              label: 'Category',
              initialValue: widget.item.category,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
