import 'package:flutter/material.dart';

class Userprofilescreen extends StatefulWidget {
  Userprofilescreen({super.key});

  @override
  State<Userprofilescreen> createState() => _UserprofilescreenState();
}

class _UserprofilescreenState extends State<Userprofilescreen> {
  String dropdownvalue = 'Traveller';

  // List of items in our dropdown menu
  var profession = [
    'Traveller',
    'Travel Agent',
  ];

  final TextEditingController _bioController = TextEditingController();
  String? userBio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: CircleAvatar(
                        radius: 15, // Adjust size of the inner avatar
                        backgroundColor: Colors.white, // Background color for contrast
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.secondary,
                        ), // Add icon
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Update Your Profile Image',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                _buildInfoRow("Your Name:", "Ramisha"),
                _buildInfoRow("Email Address:", "ramisha@123gmail.com"),
                _buildInfoRow("Phone No:", "+92342001313"),
                _buildInfoRow("City:", "Karachi"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Choose You Are:"),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: profession.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Bio:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          if (userBio != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your Bio:",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  userBio!,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$label ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }
}
