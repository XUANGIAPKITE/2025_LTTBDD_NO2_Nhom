import 'package:flutter/material.dart';
import 'question_page.dart'; // phải import

class QuizPage extends StatelessWidget {
  final List<String> quizSets = [
    "Set 1: Basic English Vocabulary",
    "Set 2: Common Phrases",
    "Set 3: Grammar Practice",
    "Set 4: Verb Tenses",
    "Set 5: Daily Conversations",
    "Set 6: Travel English",
    "Set 7: Business English",
    "Set 8: Idioms & Expressions",
  ];

  QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("English Quiz Sets")),
      body: ListView.builder(
        itemCount: quizSets.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(
                quizSets[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.blueAccent,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        QuestionPage(setName: quizSets[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
