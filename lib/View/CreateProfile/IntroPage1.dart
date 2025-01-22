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
      body: SizedBox.expand(
        child: Container(
          color: Colors.pinkAccent,
          child: Center(
            child: Container(
              height: 500,
              child: Center(
                child: Column(
                  children: [
                    Text('Please Enter Your Details as we Continue'),
                    Text('What is your Good Name'),
                    CustomTextField(controller: nameController, label: 'Name?', hint: 'Name', icon: Icons.person),
                    Text('Where we can Contact You'),
                    CustomTextField(controller: phoneNumberController, label: 'Number', hint: '0301000000', icon: Icons.phone,keyboardType: TextInputType.phone,),
                    Text('Enter Your Adress Kindly'),
                    CustomTextField(controller: addressController, label: 'Adress', hint: 'district,state', icon: Icons.place),
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
