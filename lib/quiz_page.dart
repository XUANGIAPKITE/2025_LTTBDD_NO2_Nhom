import 'package:flutter/material.dart';
import 'question_page.dart';

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
      appBar: AppBar(
        title: const Text("English Quiz Sets"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: quizSets.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionPage(
                      quizTitle: quizSets[index],
                      questions: _getQuestionsForSet(index),
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          quizSets[index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.teal,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> _getQuestionsForSet(int index) {
  switch (index) {
    case 0:
      return [
        {
          "question": "What is the plural of 'child'?",
          "options": ["childs", "children", "childes", "childrens"],
          "answer": "children",
        },
        {
          "question": "Which one is a verb?",
          "options": ["book", "run", "sky", "apple"],
          "answer": "run",
        },
      ];
    case 1:
      return [
        {
          "question": "How do you say 'Xin chào' in English?",
          "options": ["Goodbye", "Hello", "Thanks", "Please"],
          "answer": "Hello",
        },
        {
          "question": "How do you say 'Cảm ơn' in English?",
          "options": ["Sorry", "Please", "Thank you", "Good luck"],
          "answer": "Thank you",
        },
      ];
    default:
      return [
        {
          "question": "Default question?",
          "options": ["A", "B", "C", "D"],
          "answer": "A",
        },
      ];
  }
}
