import 'package:flutter/material.dart';

class Detailsoftravelcards extends StatelessWidget {

  final String image;
  final String text;
  final String no_of_days;
  final String description;
  final String Stars;
  final String price;

  const Detailsoftravelcards(
  {super.key,
  required this.image,
  required this.text,
  required this.description,
  required this.price,
  required this.no_of_days,
  required this.Stars});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(text)), // Title of the page
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(image, height: 200, width: double.infinity, fit: BoxFit.cover),
              ),
            ),

            SizedBox(height: 16),

            // Title
            Text(
              text,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            // Description
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            SizedBox(height: 16),

            // Row with Stars, Price, and Days
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text(Stars, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(
                  "\$$price",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 18, color: Colors.blueGrey),
                    SizedBox(width: 4),
                    Text("$no_of_days Days", style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30,),
            // Center(child: Text('What is including in the package?', style: TextStyle(
            //   fontSize: 20,
            //   color: Colors.green,
            // ),)),

          ],
        ),
      ),
    );
  }
}
