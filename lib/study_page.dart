import 'package:flutter/material.dart';
import 'lesson_detail_page.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> lessons = [
      {
        "title": "Lesson 1: Alphabet",
        "desc": "Learn English letters A to Z.",
        "video": "https://www.youtube.com/watch?v=um3YrKRfsr0",
        "quiz": {
          "question": "What is the first letter in the English alphabet?",
          "options": ["B", "A", "Z", "D"],
          "answer": 1,
        },
      },
      {
        "title": "Lesson 2: Numbers",
        "desc": "Counting from 1 to 100.",
        "video": "https://www.youtube.com/watch?v=DR-cfDsHCGA",
        "quiz": {
          "question": "What number comes after 9?",
          "options": ["10", "11", "8", "20"],
          "answer": 0,
        },
      },
      {
        "title": "Lesson 3: Basic Phrases",
        "desc": "Common greetings and expressions.",
        "video": "https://www.youtube.com/watch?v=dFfpwusojjA",
        "quiz": {
          "question": "What do you say when you meet someone?",
          "options": ["Goodbye", "Hello", "Sorry", "Thanks"],
          "answer": 1,
        },
      },
      {
        "title": "Lesson 4: Food & Drinks",
        "desc": "Names of foods and drinks.",
        "video": "https://www.youtube.com/watch?v=yezpvLy6eRM",
        "quiz": {
          "question": "Which one is a drink?",
          "options": ["Apple", "Water", "Rice", "Fish"],
          "answer": 1,
        },
      },
      {
        "title": "Lesson 5: Travel",
        "desc": "Useful travel expressions.",
        "video":
            "https://www.youtube.com/watch?v=2BhuZARr-QY&list=PLOCvbe7RB9faAmKDaN2WfhRW8p0C3EZnL",
        "quiz": {
          "question": "What do you say when asking for directions?",
          "options": [
            "Where is the nearest station?",
            "I like pizza.",
            "Good morning!",
            "Can I help you?",
          ],
          "answer": 0,
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Study Lessons")),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(lesson["title"] as String),
              subtitle: Text(lesson["desc"] as String),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonDetailPage(
                      title: lesson["title"] as String,
                      desc: lesson["desc"] as String,
                      videoUrl: lesson["video"] as String,
                      quiz: lesson["quiz"] as Map<String, dynamic>,
                    ),
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
