import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  final String text1;
  final String text2;

  const NotificationWidget({super.key, required this.text1, required this.text2}); // Marked as const

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),

        /// See Who has Liked your Package
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              'See Who has Liked your Package',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        /// Scrollable List of Liked Packages
        SizedBox(
          height: 220, // Fixed height for the scrollable section
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(3, (index) => _buildCard(text1)), // 5 sample cards
            ),
          ),
        ),

        SizedBox(height: 20),

        /// See Who has Favorited You
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              'See Who has Favorited You',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        /// Scrollable List of Favorited Users
        SizedBox(
          height: 250, // Fixed height for the scrollable section
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(3, (index) => _buildCard(text2)), // 5 sample cards
            ),
          ),
        ),
      ],
    );
  }

  /// Method to Build Each Card
  Widget _buildCard(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(text),
              Icon(Icons.favorite, color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}
