import 'package:flutter/material.dart';

class IntropageStart extends StatelessWidget {
  IntropageStart({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Theme.of(context).canvasColor,
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 200,),
                  Image.asset('assets/images/AppLogo-TripMates.png'),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text('KINDLY COMPLETE YOUR PROFILE IN JUST FEW STEPS',
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                  ),
                  SizedBox(height: 20,),
                 ],
              ),
            )
        ),
      ),
    );
  }
}
