import 'package:flutter/material.dart';
class TravelguideCard extends StatelessWidget {

  final String image;
  final String text;
  final String description;
  final  IconData icon;
  final int Rating;

  const TravelguideCard({super.key, required this.image, required this.text, required this.description, required this.icon, required this.Rating});

  @override
  Widget build(BuildContext context) {
    return Center(
    child: Card(
      elevation: 8, // Adds shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Container(
        width: 200,
        padding: EdgeInsets.all(10), // Padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    image,
                    height: 70,
                    width: 70,
                  ),
                ),
                Row(
                  children: List.generate(
                    Rating, // Generate stars based on the rating
                        (index) => const Icon(Icons.star, color: Colors.amber, size: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12), // Spacing between image and text
            // Title text
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 8),
            // Subtitle text
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            // Button at the bottom
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text("See Details",style: TextStyle(color: Theme.of(context).colorScheme.surface),),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
