import 'package:flutter/material.dart';
class TravelguideCard extends StatelessWidget {

  final Rating;
  final Map<String, String> user;

  const TravelguideCard({super.key, required this.user, required this.Rating});

  @override
  Widget build(BuildContext context) {


    return Center(
    child: Card(
      elevation: 8, // Adds shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Container(
        width: 250,
        padding: EdgeInsets.all(10), // Padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    user["photoUrl"]?? "",
                    height: 80,
                    width: 100,
                  ),
                ),
                Row(
                  children: List.generate(
                    Rating,
                        (index) => const Icon(Icons.star, color: Colors.amber, size: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12), // Spacing between image and text
            // Title text
            Text(
              user["name"]?? "",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 8),
            // Subtitle text
            Text(
              user["description"]?? "no bio for now",
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
