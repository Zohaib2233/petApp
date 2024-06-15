import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class RecommendationOutput extends StatelessWidget {
  final String text;
  const RecommendationOutput({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    print(text);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommendations"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
          child: ListView(
            children: [
              MarkdownBody(data: text),

            ],
          ),
        ),
      ),
    );
  }
}
