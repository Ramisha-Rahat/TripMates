import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/creatingProfileController.dart';

class IntropageStart extends StatelessWidget {
  IntropageStart({super.key});

  final CreatingProfileController _controller = Get.find<CreatingProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Theme.of(context).canvasColor,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/AppLogo-TripMates.png'),
                  const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(
                      'KINDLY COMPLETE YOUR PROFILE IN JUST A FEW STEPS',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const Text('You signed up as:'),
                  Obx(() {
                    final photoUrl = _controller.photoUrl.value;
                    final displayName = _controller.displayName.value;
                    final email = _controller.email.value;

                    return Column(
                      children: [
                        if (photoUrl.isNotEmpty) // Show profile picture if available
                          CircleAvatar(
                            backgroundImage: NetworkImage(photoUrl),
                            radius: 40,
                          )
                        else
                          const Icon(Icons.account_circle, size: 80),
                        const SizedBox(height: 20),
                        Text(
                          displayName,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        if (email.isNotEmpty) // Show email if available
                          Text(
                            email,
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
