import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final String number;
  final String text;

  const CardList({Key? key, required this.number, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1)),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(padding: EdgeInsets.only(right: 10)),
            Icon(
              Icons.circle,
              color: Colors.blue,
              size: 15,
            ),
            Padding(padding: EdgeInsets.only(right: 5)),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                '#5213',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 40)),
            SizedBox(
              width: 250,
              child: Text(
                '50/ 5.4 , Bvay ,d8564fnf fghfgh fdsdfsdfsdfsdfsdfsdsfdfsd',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Icon(
                Icons.arrow_right_rounded,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
