import '../models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/label_Item.dart';

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
              initialValue: widget.item.materialNo,
            ),
            LabelValueFormField(
              label: 'Category',
              initialValue: widget.item.description,
            ),
            LabelValueFormField(
              label: 'Bin Number',
              initialValue: widget.item.binNo,
            ),
            LabelValueFormField(
              label: 'Value Stock',
              initialValue: widget.item.valStock,
            ),
            LabelValueFormField(
              label: 'Max Price',
              initialValue: widget.item.maxPrice,
            ),
            // LabelValueFormField(
            //   label: 'Value',
            //   initialValue: widget.item.value,
            // ),
            LabelValueFormField(
              label: 'UOM',
              initialValue: widget.item.uom,
            ),
            LabelValueFormField(
              label: 'Storage Location',
              initialValue: widget.item.storageLoc,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
