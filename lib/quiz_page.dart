import 'package:flutter/material.dart';
import 'question_page.dart'; // phải import

class QuizPage extends StatelessWidget {
  final List<String> quizSets = [
    "Goi 1: Flutter Basics",
    "Goi 2: Firebase",
    "Goi 3: Cau truc du lieu",
  ];

  QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Sets")),
      body: ListView.builder(
        itemCount: quizSets.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(quizSets[index]),
              trailing: const Icon(Icons.arrow_forward),
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
