import 'package:flutter/material.dart';
import 'package:tripmates/View/HomeScreenTravelAgent/detailsOfTravelCards.dart';
import 'package:tripmates/widgets/travel_card_citywise.dart';

class Homepageagent extends StatefulWidget {
  const Homepageagent({super.key});

  @override
  State<Homepageagent> createState() => _HomepageagentState();
}

class _HomepageagentState extends State<Homepageagent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
        color: Theme.of(context).secondaryHeaderColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100,),

                 GestureDetector(
                   onTap: (){
                     Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context)=> Detailsoftravelcards(
                             image:'assets/images/AppLogo-TripMates.png' ,
                             text: 'Brazil For 5 Days',
                             description: 'Travel Brazil with the best Crew,'
                                 'Travel Brazil with the best Crew'
                                 'Travel Brazil with the best Crew'
                                 'Travel Brazil with the best Crew'
                                 'Travel Brazil with the best Crew',
                             price: '567',
                             no_of_days: '5',
                             Stars: '4.2'
                         ))
                     );
                   },
                   child: TravelCardCitywise(
                       image:'assets/images/AppLogo-TripMates.png' ,
                       text: 'Brazil For 5 Days',
                        description: '',
                       price: '567',
                       no_of_days: '5',
                       Stars: '4.2'
                   ),
                 ),

              SizedBox(height: 20,),

          
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
