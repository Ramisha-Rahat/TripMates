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
    _controller.fetchUserData();
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
                  Obx(() => CircleAvatar(
                    radius: 70,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    backgroundImage: _controller.photoUrl.value.isNotEmpty
                        ? NetworkImage(_controller.photoUrl.value) // Show stored image
                        : null,
                    child: _controller.photoUrl.value.isEmpty
                        ? Icon(Icons.person, size: 70, color: Colors.white) // Default icon
                        : null,
                  )),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: GestureDetector(
                        onTap: () async {
                          await _controller.pickAndUploadImage(); // Upload and save
                        },
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
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


              Obx(() => ListTile(
                title: Text("Name",style: TextStyle(fontSize: 20),),
                subtitle: Text(_controller.displayName.value, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showUpdateDialog("Name", _controller.displayName),
                ),
              )),


              Obx(() => ListTile(
                title: Text("Email",style: TextStyle(fontSize: 20),),
                subtitle: Text(_controller.email.value, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              )),

              Obx(() => ListTile(
                title: Text("Phone Number",style: TextStyle(fontSize: 20),),
                subtitle: Text(_controller.userPhone.value, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showUpdateDialog("Phone Number", _controller.userPhone),
                ),
              )),


              Obx(() => ListTile(
                title: Text("City",style: TextStyle(fontSize: 20),),
                subtitle: Text(_controller.userAddress.value, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showUpdateDialog("City", _controller.userAddress),
                ),
              )),


              Obx(() => ListTile(
                title: Text("Role",style: TextStyle(fontSize: 20),),
                subtitle: Text(_controller.selectedRole.value, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              )),


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
