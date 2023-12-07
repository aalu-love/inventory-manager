import 'package:flutter/material.dart';

class MyDeveloperAboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer About Page'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'S. Bodra',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Full Stack Developer',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 16),
            Text(
              'Contact:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Email: sanjubodra1420@gmail.com'),
            Text('GitHub: github.com/aalu-love'),
          ],
        ),
      ),
    );
  }
}
