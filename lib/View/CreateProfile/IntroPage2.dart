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
        child: Container(
          color: Colors.orangeAccent,
          child: Center(
            child: Container(
              height: 500,
              child: Center(
                child: Column(
                  children: [
                    Text('Describe Yourself! A SHORT BIO?'),
                    TextField(
                      controller: _bioController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Write a short bio about yourself (4-5 lines)...",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
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
                      child: Text("Save Bio"),
                    ),
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}
