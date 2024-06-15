import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_pal/core/utils/app_strings.dart';
import 'package:pet_pal/models/pets_model.dart';
import 'package:pet_pal/view/screens/myPetsScreen/myPetDetail/recomendation_output.dart';
import 'package:pet_pal/view/widgets/my_button.dart';
import 'package:pet_pal/view/widgets/my_text_widget.dart';

class RecommendationScreen extends StatefulWidget {
  final PetsModel petsModel;

  const RecommendationScreen({super.key, required this.petsModel});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    // Adjust the corner radius as needed
                    child: Image.asset(
                      'assets/images/ai_robot.jpg', // Adjust the image path
                      width: 300, // Adjust the width as needed
                      height: 300, // Adjust the height as needed
                    ),
                  ),
                  SizedBox(height: 20),
                  MyText(
                    text: "Get Food Recommendations for Your Pet Through AI",
                    weight: FontWeight.bold,
                    size: 18,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  MyButton(
                      onTap: () async {
                        // final apiKey = Platform.environment[AppStrings.geminiApiKey];
                        // if (apiKey == null) {
                        //   print('No \$API_KEY environment variable');
                        // }
                        // For text-and-image input (multimodal), use the gemini-pro-vision model
                        // final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);
                        // const prompt = 'Write a story about a magic backpack.';
                        // final content = [Content.text(prompt)];
                        // print(prompt);
                        // final response = await model.generateContent(content);
                        //
                        // print(response.text);

                        // final apiKey = Platform.environment['API_KEY'];
                        // if (apiKey == null) {
                        //   print('No \$API_KEY environment variable');
                        //   exit(1);
                        // }
                        // For text-only input, use the gemini-pro model

                        setState(() {
                          loading = true;
                        });

                        print(
                            "String.fromEnvironment('api_key') = ${String.fromEnvironment('api_key')}");
                        final model = GenerativeModel(
                            model: 'gemini-pro',
                            apiKey: AppStrings.geminiApiKey);
                        final content = [
                          Content.text(
                              'Give me food recommendation for my dog name ${widget.petsModel.petName} he is ${widget.petsModel.breed} ${widget.petsModel.gender} ${widget.petsModel.petAge} year old give me in points without any note and also mention dog name gender, breed and age in 1st line as heading as Recommendation for your dog {name} are')
                        ];
                        print('content');
                        final response = await model.generateContent(content);
                        print("Get Recommendation = ${response.text}");
                        setState(() {
                          loading = false;
                        });
                        Get.to(() =>
                            RecommendationOutput(text: response.text ?? ''));
                      },
                      buttonText: "Get Recommendation"),
                ],
              ),
            ),
          ),
          loading
              ? Container(
                  color: Colors.grey.withOpacity(0.9),
                  height: Get.height,
                  width: Get.width,
                  child: Center(
                    child: Lottie.asset('assets/robot1 - 1715802542136.json'),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void getRecommendation(BuildContext context) {
    // Call your AI model or API to get recommendations
    // Display the recommendations using a dialog or navigate to another screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recommendations'),
          content: Text('Here are some recommended foods for your pet.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
