import 'package:flutter/material.dart';

class Intropage2 extends StatefulWidget {
   Intropage2({super.key});

  @override
  State<Intropage2> createState() => _Intropage2State();
}

class _Intropage2State extends State<Intropage2> {
 final TextEditingController _bioController=TextEditingController();

   String? userBio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: Container(
            color: Theme.of(context).canvasColor,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Image.asset('assets/images/AppLogo-TripMates.png'),
                  SizedBox(height: 20,),
                  Text('Describe Yourself! A SHORT BIO?',
                  style: TextStyle(
                    fontSize: 20
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: _bioController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Write a short bio about yourself (max 4 lines)",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        userBio = _bioController.text.trim();
                        _bioController.clear(); // Clear the TextField after saving
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Custom background color
                      foregroundColor: Colors.black, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                    ),
                    child: Text("Save Bio"),
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
