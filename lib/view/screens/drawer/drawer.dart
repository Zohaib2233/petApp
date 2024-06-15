import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pet_pal/core/constants/app_colors.dart';
import 'package:pet_pal/core/global/variables.dart';
import 'package:pet_pal/view/screens/profile/edit_profile.dart';
import 'package:pet_pal/view/screens/profile/my_profile.dart';
import 'package:pet_pal/view/widgets/common_image_view_widget.dart';


import '../../../core/utils/dialogs.dart';
import '../../widgets/buttons/back_button.dart';
import '../../widgets/drawer/drawer_tabs.dart';



class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  // @override
  // void dispose() {
  //   print("close");
  //   Navigator.pop(context);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(

      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.0),
        ),
        child: Drawer(


          backgroundColor: kWhiteColor,

          width: 260,
          child: ListView(
            children: [
             Padding(
               padding: EdgeInsets.only(
                 right: width*0.5,
                 top: 20,
                 bottom: 26
               ),
               child: CustomBackButton(color:kBlackColor1),
             ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Obx(()=>CommonImageView(
                    radius: 30,
                      width: 55,
                      height: 55,
                      url: userModelGlobal.value.profileUrl,
                    ),
                  ),
                  // CircleAvatar(
                  //   radius: 30,
                  //   backgroundImage: AssetImage('assets/images/profile_img.png'),
                  // ),
                  SizedBox(width: 15,),
                  Obx(()=>Text("${userModelGlobal.value.name}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Divider(
                thickness: 2,
              ),
            ),
            DrawerTab(icon: Icons.account_circle,
                tabName: 'My Profile',
                onTap: (){
              Get.to(()=>MyProfile(userModel: userModelGlobal.value,));

            }),




              DrawerTab(icon: Icons.account_circle,
                  tabName: 'Edit Profile',
                  onTap: (){
                Get.to(()=>EditProfilePage());
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
                  }),
              // DrawerTab(icon: Icons.pets_rounded,
              //     tabName: 'Check Pet Mood',
              //     onTap: (){
              //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs()));
              //     }),

              DrawerTab(icon: Icons.logout,
                  tabName: 'LogOut',
                  onTap: (){
                        showLogoutDialog(context);
                  }),

            ],
          ),
        ),
      ),
    );
  }
}


