import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripmates/bindings/creatingProfileScreenBinding.dart';

import '../../controller/creatingProfileController.dart';

class Intropage3 extends StatefulWidget {
  const Intropage3({super.key});

  @override
  State<Intropage3> createState() => _Intropage3State();
}

class _Intropage3State extends State<Intropage3> {

  final CreatingProfileController _controller = Get.find<CreatingProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: Container(
            height: 500,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Choose your role:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller.selectRole('Traveller');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'I am a Traveller',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller.selectRole('Travel Agent');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'I am a Travel Agent',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 40),
                // Display the selected role message
                Text(
                  _controller.selectedRole.value.isEmpty
                      ? 'Please select your role.'
                      : 'You have chosen to be a ${_controller.selectedRole.value}.',
                  style: TextStyle(
                    fontSize: 18,
                    color: _controller.selectedRole.isEmpty ? Colors.red : Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
