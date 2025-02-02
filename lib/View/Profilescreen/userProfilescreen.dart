// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tripmates/controller/userProfileController.dart';
//
// class Userprofilescreen extends StatefulWidget {
//   Userprofilescreen({super.key});
//
//   @override
//   State<Userprofilescreen> createState() => _UserprofilescreenState();
// }
//
// class _UserprofilescreenState extends State<Userprofilescreen> {
//
//   String? userBio;
//
//   @override
//   Widget build(BuildContext context) {
//     final _controller = Get.find<UserProfileController>();
//
//
//     final displayName = _controller.displayName.value;
//     final email = _controller.email.value;
//     final userName=_controller.userName.value;
//     final phoneNo=_controller.userPhone.value;
//     final Adress=_controller.userAddress.value;
//     final Bio=_controller.userBio.value;
//
//
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("User Profile"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: 20),
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 70,
//                       backgroundColor: Theme.of(context).colorScheme.primary,
//                     ),
//                     Positioned(
//                       bottom: 10,
//                       right: 10,
//                       child: CircleAvatar(
//                         radius: 15,
//                         // Adjust size of the inner avatar
//                         backgroundColor: Colors.white,
//                         // Background color for contrast
//                         child: Icon(
//                           Icons.add,
//                           color: Theme.of(context).colorScheme.secondary,
//                         ), // Add icon
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Update Your Profile Image',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 20),
//
//                 Column(
//                   children: [
//                     Row(
//                       children: [
//                         Text('Your Name:  '),
//                         Text(userName),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text('Email:  '),
//                         Text(email),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text('Phone Number:  '),
//                         Text(phoneNo),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Text('City:  '),
//                         Text(Adress),
//                       ],
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Your Role is of '),
//                     SizedBox(width: 10),
//                     Text(_controller.selectedRole.value),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Add Bio:',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 10),
//                           Text(Bio),
//                           SizedBox(height: 20),
//                           ElevatedButton(
//                             onPressed: () {
//
//                             },
//                             child: Text("Save Bio"),
//                           ),
//                         ],
//                       ),
//
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/controller/userProfileController.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserProfileController _controller = Get.find<UserProfileController>();

  @override
  void initState() {
    super.initState();
    _controller.fetchUserData(); // Load user data when screen opens
  }

  void _showUpdateDialog(String field, RxString fieldValue) {
    TextEditingController controller = TextEditingController(text: fieldValue.value);

    Get.defaultDialog(
      title: "Update $field",
      content: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: "Enter new $field"),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            fieldValue.value = controller.text;
            _controller.updateUserProfile(); // Update only the modified field
            Get.back(); // Close dialog
          },
          child: Text("Update"),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text("Cancel"),
        ),
      ],
    );
  }

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
                        radius: 15,
                        // Adjust size of the inner avatar
                        backgroundColor: Colors.white,
                        // Background color for contrast
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

              /// **Name Field**
              Obx(() => ListTile(
                title: Text("Name",style: TextStyle(fontSize: 20),),
                subtitle: Text(_controller.displayName.value, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showUpdateDialog("Name", _controller.displayName),
                ),
              )),

              /// **Email Field (Uneditable)**
              Obx(() => ListTile(
                title: Text("Email",style: TextStyle(fontSize: 20),),
                subtitle: Text(_controller.email.value, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              )),

              /// **Phone Number Field**
              Obx(() => ListTile(
                title: Text("Phone Number",style: TextStyle(fontSize: 20),),
                subtitle: Text(_controller.userPhone.value, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showUpdateDialog("Phone Number", _controller.userPhone),
                ),
              )),

              /// **City Field**
              Obx(() => ListTile(
                title: Text("City",style: TextStyle(fontSize: 20),),
                subtitle: Text(_controller.userAddress.value, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showUpdateDialog("City", _controller.userAddress),
                ),
              )),

              /// **Role Display (Non-editable)**
              Obx(() => ListTile(
                title: Text("Role",style: TextStyle(fontSize: 20),),
                subtitle: Text(_controller.selectedRole.value, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              )),

              /// **Bio Field**
              Obx(() => ListTile(
                title: Text("Bio",style: TextStyle(fontSize: 20),),
                subtitle: Text(_controller.userBio.value, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showUpdateDialog("Bio", _controller.userBio),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
