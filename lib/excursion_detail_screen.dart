import 'package:flutter/material.dart';
import 'package:test_task/excursion.dart';

class ExcursionDetailScreen extends StatelessWidget {
  final Excursion excursion;

  const ExcursionDetailScreen({super.key, required this.excursion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(excursion.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(excursion.imageUrl[0]),
            SizedBox(height: 16),
            Text(
              excursion.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(excursion.description),
            SizedBox(height: 8),
            Text('Price: ${excursion.price} €', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
