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

  //   final String materialNo;
  // final String desription;
  // final String binNo;
  // final String valueStock;
  // final String avgPrice;
  // final String value;
  // final String uom;
  // final String storageLoc;

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
              initialValue: widget.item.desription,
            ),
            LabelValueFormField(
              label: 'Bin Number',
              initialValue: widget.item.binNo,
            ),
            LabelValueFormField(
              label: 'Value Stock',
              initialValue: widget.item.valueStock,
            ),
            LabelValueFormField(
              label: 'Average Price',
              initialValue: widget.item.avgPrice,
            ),
            LabelValueFormField(
              label: 'Value',
              initialValue: widget.item.value,
            ),
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
