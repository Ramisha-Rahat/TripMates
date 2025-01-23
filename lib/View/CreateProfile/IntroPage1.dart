import 'package:flutter/material.dart';
import 'package:tripmates/widgets/custom_textFields.dart';

class Intropage1 extends StatelessWidget {
   Intropage1({super.key});

   final TextEditingController nameController=TextEditingController();
   final TextEditingController phoneNumberController=TextEditingController();
   final TextEditingController addressController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Theme.of(context).canvasColor,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30,),
                Image.asset('assets/images/AppLogo-TripMates.png'),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Please Enter Your Details as we Continue',
                  style: TextStyle(
                    fontSize: 20,
                  ),),
                ),
                SizedBox(height: 20,),
                Text('What is your Good Name',
                style: TextStyle(
                  fontSize: 20,
                ),),
                SizedBox(height: 10,),
                CustomTextField(controller: nameController, label: 'Name?', hint: 'Name', icon: Icons.person,),
                SizedBox(height: 20,),
                Text('Where we can Contact You',
                  style: TextStyle(
                  fontSize: 20,
                ),),
                SizedBox(height: 10,),
                CustomTextField(controller: phoneNumberController, label: 'Number', hint: '0301000000', icon: Icons.phone,keyboardType: TextInputType.phone,maxLength: 11,),
                SizedBox(height: 20,
                ),
                Text('Enter Your Adress Kindly',
                  style: TextStyle(
                  fontSize: 20,
                ),),
                SizedBox(height: 10,),
                CustomTextField(controller: addressController, label: 'Adress', hint: 'district,state', icon: Icons.place),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Custom background color
                    foregroundColor: Colors.black, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: Text("Save Deatils"),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
