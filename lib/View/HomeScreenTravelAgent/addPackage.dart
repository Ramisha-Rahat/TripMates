import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/controller/agentHomePageController.dart';

class Addpackage extends StatelessWidget {
  final AgentHomePageController _controller = Get.find<AgentHomePageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Travel Package")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() => GestureDetector(
                  onTap: _controller.pickAndUploadImage,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _controller.photoUrl.value.isNotEmpty
                        ? NetworkImage(_controller.photoUrl.value)
                        : null,
                    child: _controller.photoUrl.value.isEmpty
                        ? Icon(Icons.camera_alt, size: 50)
                        : null,
                  ),
                )),
                SizedBox(height: 20),
                buildTextField("Title", _controller.textController),
                buildTextField("Description", _controller.descriptionController),
                buildTextField("Price", _controller.priceController, TextInputType.number),
                buildTextField("Days", _controller.noOfDaysController, TextInputType.number),
                buildTextField("Stars", _controller.starsController, TextInputType.number),
                SizedBox(height: 20),
                Obx(() => _controller.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _controller.uploadImageAndSavePackage,
                  child: Text("Add Package"),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget buildTextField(String label, TextEditingController controller, [TextInputType type = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        keyboardType: type,
        validator: (value) => value!.isEmpty ? "Enter $label" : null,
      ),
    );
  }
}
