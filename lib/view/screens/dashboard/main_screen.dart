import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pet_pal/core/bindings/bindings.dart';
import 'package:pet_pal/core/constants/app_colors.dart';
import 'package:pet_pal/view/widgets/common_image_view_widget.dart';

import '../add_pet/add_pet_screen.dart';
import '../drawer/drawer.dart';
import '../homeScreen/home_Screen.dart';
import '../myPetsScreen/my_pets.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex =0;

  final List<Widget> screens =[
    const HomeScreen(),
    const MyPetsScreen()
  ];


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(

      drawer: const CustomDrawer(),
      appBar: AppBar(
        foregroundColor: kSecondaryColor,
        title: CommonImageView(imagePath: 'assets/images/pet_pal_logo.png',
        height: 45,),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
            size: 40,
            color: kSecondaryColor
        ),

      ),


      body: screens[_selectedIndex],
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,

          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 1),
          ],
        ),
        child: FloatingActionButton.large(
          shape: const CircleBorder(),
          backgroundColor: kSecondaryColor,
          child: const Icon(Icons.add,color: kWhiteColor,size: 55,),
          onPressed: (){
            Get.to(()=>const AddPetScreen(),binding: AddPetBinding());
            // showSOSDialog(context);
          },

        ),
      ),
      resizeToAvoidBottomInset: false,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 3, blurRadius: 16),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: kWhiteColor,
            onTap: (index){

              setState(() {
                _selectedIndex=index;

              });
            },
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(right: width*0.1),
                      child: SvgPicture.asset('assets/images/home_icon.svg',

                        color: _selectedIndex==0?kSecondaryColor:
                        Colors.black,)),
                  label: ''
              ),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(left: width*0.1),
                      child: Icon(Icons.pets,
                        size: 35,
                        color: _selectedIndex==1?kSecondaryColor:
                        Colors.black,)),
                  label: ''
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2 + 20, 0); // Adjust the value to control the curve
    path.quadraticBezierTo(size.width / 2, 30, size.width / 2 - 20, 0); // Adjust the value to control the curve
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
