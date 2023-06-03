import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Duludasa',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var currentPage = 2;
  String _searchText = '';
  List<List<dynamic>> data = [];
  List<List<dynamic>> _data = [];

  void _onSearchTextChanged(String value) {
    setState(() {
      _searchText = value;
    });
  }

  void onPressedAction() {
    print('Button pressed!');
    // Add any additional actions you want to perform here
  }

  void _loadCSV() async {
    final rawData = await rootBundle.loadString("assets/appsheet.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    setState(() {
      listData.removeAt(0);
      data = listData;
    });
  }

  StatelessWidget renderComponent(pageIndex) {
    if (pageIndex == 0) {
      return TableList(totalCount: data.length, totalData: data);
    } else if (pageIndex == 1) {
      return CategoryHeader(totalData: data);
    } else if (pageIndex == 2) {
      return const CardDetail();
    }
    return const Text('Hi there !!');
  }

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  Future<void> _openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      _readCSV(file.path!);
    } else {
      // User cancelled the file selection, show a message or perform an action
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No file selected'),
            content: const Text('Please select a CSV file.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _readCSV(String filePath) async {
    final input = File(filePath).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();

    setState(() {
      _data = fields;
    });
    print(_data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: currentPage == 2 ? const Backbar() : const DefaultAppBar(),
      ),
      body: renderComponent(currentPage),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Table',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.percent_outlined),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ice_skating),
            label: 'Home',
          ),
        ],
        currentIndex: currentPage,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (pageIndex) => setState(() {
          currentPage = pageIndex;
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFilePicker(),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: null,
      automaticallyImplyLeading: false,
      actions: const [
        SizedBox(
          width: 400,
          child: TextField(
            // onChanged: _onSearchTextChanged,
            decoration: InputDecoration(
              filled: true,
              hintText: 'Search...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide.none,
              ),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }
}

class Backbar extends StatelessWidget {
  const Backbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: null,
      automaticallyImplyLeading: false,
      leading: const Icon(Icons.arrow_back),
    );
  }
}

class CardDetail1 extends StatelessWidget {
  const CardDetail1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Hi form 1'),
    );
  }
}

class CategoryHeader extends StatelessWidget {
  final List<List<dynamic>> totalData;
  const CategoryHeader({Key? key, required this.totalData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> categoryList = [];

    const int machineIndex = 1;

    Set<String> getCategorySet(List<List<dynamic>> machineList) {
      return machineList
          .map((machine) => machine[machineIndex].toString())
          .toSet();
    }

    // List<dynamic> getDetailByCategory =
    //     totalData.where((row) => row[1].contains('Oil')).toList();
    // print(getDetailByCategory);

    Set<String> categorySet = getCategorySet(totalData);
    categoryList = categorySet.toList();

    return ListView.builder(
      itemCount: categoryList.isNotEmpty ? categoryList.length : 0,
      itemBuilder: (_, index) {
        return SizedBox(
          child: Container(
            margin: const EdgeInsets.only(bottom: 2),
            padding: const EdgeInsets.only(left: 10, top: 8),
            color: const Color.fromARGB(95, 158, 158, 158),
            height: 35,
            child: Text(
              categoryList[index],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final List<String> data;
  const CategoryCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          child: const SizedBox(
            height: 50,
            child: Card(
              child: Text('Hello'),
            ),
          ),
        );
      },
    );
  }
}

class TableList extends StatelessWidget {
  final int totalCount;
  final List<List<dynamic>> totalData;
  const TableList({Key? key, required this.totalCount, required this.totalData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: totalCount,
      itemBuilder: (_, index) {
        var detailOne = totalData[index];
        return CardComponent(index: index, detail: detailOne);
      },
    );
  }
}

class CardComponent extends StatelessWidget {
  final int index;
  final List<dynamic> detail;

  final int itemCode = 6;
  final int decsription = 2;
  const CardComponent({Key? key, required this.index, required this.detail})
      : super(key: key);

  void _onTabDown(tabDetail) {
    print(tabDetail);
    // Show detail page
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CardDetail(),
          ),
        );
      },
      child: SizedBox(
        height: 44,
        child: Card(
          margin: const EdgeInsets.all(0.3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 15)),
                  SizedBox(
                      width: 120,
                      child: detail[itemCode].toString() != ''
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 17,
                                  color: Colors.blue,
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 2)),
                                Text(
                                  detail[itemCode].toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.circle,
                                  size: 17,
                                  color: Colors.red,
                                ),
                                Padding(padding: EdgeInsets.only(left: 2)),
                                Text(
                                  'Not Available',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                  const Padding(padding: EdgeInsets.only(left: 2)),
                  SizedBox(
                    width: 250,
                    child: Text(
                      detail[decsription].toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardDetail extends StatelessWidget {
  const CardDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            InputField(label: "Name", dataValue: 'Hello'),
            InputField(
              label: "Cold",
              dataValue:
                  "Hello Hello HelloHello HelloHello HelloHello HelloHello Hello Hello HelloHello HelloHello HelloHello HelloHello",
            ),
            InputField(
              label: "Marine",
              dataValue: "HelloHelloHello Hello",
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final String dataValue;

  const InputField({Key? key, required this.label, required this.dataValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  "$label:",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                width: 288,
                child: Text(
                  dataValue.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
