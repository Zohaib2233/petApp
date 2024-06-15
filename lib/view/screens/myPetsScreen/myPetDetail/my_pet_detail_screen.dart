import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pet_pal/models/pets_model.dart';

import 'package:pet_pal/view/screens/myPetsScreen/myPetDetail/tabs/about_pet_screen.dart';
import 'package:pet_pal/view/screens/myPetsScreen/myPetDetail/tabs/entertainment_screen.dart';
import 'package:pet_pal/view/screens/myPetsScreen/myPetDetail/tabs/matchmaking_screen.dart';
import 'package:pet_pal/view/screens/myPetsScreen/myPetDetail/tabs/recommendation_screen.dart';
import 'package:pet_pal/view/screens/myPetsScreen/myPetDetail/tabs/vaccination_screen.dart';

import '../../../../core/constants/app_sizes.dart';

import '../../../widgets/toggle_tab_widget.dart';


class MyPetDetailScreen extends StatefulWidget {
  final PetsModel petsModel;
  const MyPetDetailScreen({super.key, required this.petsModel});

  @override
  State<MyPetDetailScreen> createState() => _MyPetDetailScreenState();
}

class _MyPetDetailScreenState extends State<MyPetDetailScreen> {

  int _currentIndex = 0;
  final List<String> _tabs = [
    'About',
    'Vaccination',
    'Matchmaking',
    'Entertainment',
    'Recommendation',
  ];



  void _getCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final List screens = [
      PetAboutScreen(petsModel: widget.petsModel,),
      VaccinationScreen(petsModel: widget.petsModel,),
      MatchMakingScreen(petsModel: widget.petsModel,),
      EntertainmentScreen(),
      RecommendationScreen(petsModel: widget.petsModel),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("My Pet Details"),
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Obx(
            //       ()=> CustomSearchBar(
            //     hint: 'Search listing here',
            //     controller: controller.searchController.value,
            //     onChanged: (val){
            //       setState(() {
            //         controller.searchController.value.text=val;
            //         if(_currentIndex==0){
            //           controller.searchListings(listings:controller.allListings);
            //         }
            //         if(_currentIndex==1){
            //           controller.searchListings(listings:controller.pendingListings);
            //         }
            //         if(_currentIndex==2){
            //           controller.searchListings(listings:controller.confirmedListings);
            //         }
            //         if(_currentIndex==3){
            //           controller.searchListings(listings:controller.completedListings);
            //         }
            //         if(_currentIndex==4){
            //           controller.searchListings(listings:controller.cancelledListings);
            //         }
            //
            //       });
            //     },
            //   ),
            // ),

            SizedBox(height: 10,),
            SizedBox(
              height: 35,
              child: ListView.builder(
                itemCount: _tabs.length,
                scrollDirection: Axis.horizontal,
                padding: AppSizes.HORIZONTAL,
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ToggleTab(
                      tab: _tabs[index],
                      isSelected: _currentIndex == index ? true : false,
                      onTap: () => _getCurrentIndex(index),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SlidableAutoCloseBehavior(
                closeWhenOpened: true,
                closeWhenTapped: false,
                child: screens[_currentIndex],
              ),
            )
          ],
        ),
      ),
    );
  }
}
