import 'dart:math';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_pal/core/constants/app_colors.dart';
import 'package:pet_pal/core/utils/app_strings.dart';
import 'package:pet_pal/view/widgets/common_image_view_widget.dart';






class PetCard extends StatelessWidget {


  final String? petId;
  final String? petName;
  final String? breed ;
  final String? age ;
  final String? address ;
  final String? gender ;
  final String? imagePath;
  final Function()? onTap;

  PetCard({
    super.key,
    this.petId='',
    this.petName='',
    this.breed='',
    this.age='',
    this.address='',
    this.gender='',
    this.imagePath, this.onTap,

  });

  final colors = [
    Colors.blueGrey[200],
    Colors.green[200],
    Colors.pink[100],
    Colors.brown[200],
    Colors.lightBlue[200],
  ];

  Random _random = new Random();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final randomColor = colors[_random.nextInt(colors.length)];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 250,
        child: Stack(
          children: [
            Container(
              // height: 200,
              margin: const EdgeInsets.only(
                top: 70,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.grey[300] as Color,
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                )],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.48,
                  ),
                  Expanded(
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                petName??'',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                gender == 'Female'
                                    ? Icons.female
                                    : Icons.male,
                                size: 18,
                                color: Colors.black54,
                              )
                            ],
                          ),
                          Text(
                            breed??'',
                            style: const TextStyle(
                              fontSize: 12,
                              color: kBlackColor1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$age' + ' years',
                            style: const TextStyle(
                              fontSize: 12,
                              color: kBlackColor1,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                size: 16,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  '$address' ,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: kBlackColor1,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: size.width * 0.48,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: randomColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300] as Color,
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(22),
                    ),
                    margin: const EdgeInsets.only(top: 50),
                  ),
                  Align(
                    child: Hero(
                      tag: petId??'',
                      child: CommonImageView(
                        width: size.width*0.46,
                        radius: 15,
                        height: size.height*0.22,
                        fit: BoxFit.cover,
                        url: imagePath??dummyImg,
                      )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
