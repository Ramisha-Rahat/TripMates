import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  final String image;
  final String text;
  final String description;
  final String price;

  const CustomCard({super.key, required this.image, required this.text, required this.description, required this.price});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8, // Adds shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Container(
          width: 280,
          padding: EdgeInsets.all(16), // Padding inside the card
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15), // Rounded corners for the image
                    child: Image.asset(
                      image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover, // Makes the image cover the container
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
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
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text("Check",style: TextStyle(color: Theme.of(context).colorScheme.surface),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
